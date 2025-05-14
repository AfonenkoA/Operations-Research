flat_str <- \(fun, args) stringr::str_glue('{fun}({paste0(args,collapse=",")})')

SQL_FUN <- c('JOIN', 'FILTER', 'SELECT', 'AGGREGATE')

cut_tree <- function(node)
{
  if (node$name %in% igraph::V(g)$name)
    return(node$name)
  else
    return(node)
}

name_node <- function(node)
{
  val <- node$val
  n <- if (is.character(val))
    val
  else
    val$name
  args <- c(n, node[names(node) == ''])
  node$name <- flat_str(node$fun, args)
  node
}

add_node <- function(node)
{
  if (is.character(node))
    return(node)

  g <<- igraph::add_vertices(g, 1, name = node$name, fun = node$fun)

  args <- node[names(node) == ''] |> as.character()

  g <<- setdiff(c(args, node$val), igraph::V(g)$name) |>
    purrr::reduce(\(g, arg)  igraph::add_vertices(g, 1, name = arg, fun =
                                                    'base'), .init = g)

  g <<- purrr::reduce(args, \(g, v) igraph::add_edges(g, c(v, node$name), label = 'arg'), .init = g) |>
    igraph::add_edges(c(node$val, node$name), label = 'val')
  node$name
}


add_query <- function(q, name)
{
  vtx_name <- purrr::modify_tree(q, post = name_node) |>
    purrr::modify_tree(pre = cut_tree, post = add_node)
  g <<- igraph::add_vertices(g, 1, name = name, fun = 'query') |>
    igraph::add_edges(c(vtx_name, name), label = 'val')
  vtx_name
}

get_node_incoming_vetrex_id <- function(n, type)
{
  igraph::E(g)[.to(n) & label == type] |>
    igraph::tail_of(g, es = _) |>
    as.integer()
}

get_common <- function()
{
  i <- igraph::V(g)[fun %in% SQL_FUN]
  c(igraph::vertex_attr(g, index = i), list(id = as.integer(i))) |>
    tibble::as_tibble() |>
    dplyr::rowwise() |>
    dplyr::mutate(val = get_node_incoming_vetrex_id(id, 'val'),
                  args = list(get_node_incoming_vetrex_id(id, 'arg'))) |>
    dplyr::group_by(fun, val) |>
    dplyr::group_split() |>
    purrr::keep(\(df) nrow(df) > 1) |>
    purrr::map(\(df)
               {
                 fun <- unique(df$fun)
                 val <- unique(df$val)

                 l <- purrr::pmap(df, list)

                 purrr::map(2:length(l), \(i) combinat::combn(l, i, simplify = FALSE)) |>
                   do.call(c, args = _) |>
                   purrr::map(purrr::list_transpose) |>
                   purrr::map(tibble::as_tibble) |>
                   purrr::map(\(df) dplyr::select(df, -fun, -name)) |>
                   purrr::map(\(df)
                              {
                                common_args <- purrr::reduce(df$args, intersect)
                                list(
                                  common_args = common_args,
                                  unique_args = purrr::map(df$args, \(arg) setdiff(arg, common_args)),
                                  ids = df$id,
                                  fun = fun,
                                  val = val
                                )
                   }) |>
                   purrr::list_transpose() |>
                   tibble::as_tibble() |>
                   dplyr::rowwise() |>
                   dplyr::mutate(num_nodes = length(ids), args_len = length(common_args)) |>
                   dplyr::filter(args_len >= 2) |>
                   dplyr::arrange(dplyr::desc(args_len), dplyr::desc(num_nodes)) |>
                   dplyr::select(-args_len, -num_nodes) |>
                   (\(df) if(nrow(df)==0L) NULL else dplyr::first(df))()
    }) |>
    purrr::list_rbind()
}


insert_node <- function(common_args, unique_args, ids, fun, val)
{
  common_node_id <- unique_args |>
    purrr::map(length) |>
    (\(l) l == 0)() |>
    which() |>
    (\(id) ids[id])()

  if (length(common_node_id) != 0)
  {
    ids <- purrr::keep(ids, \(i) i != common_node_id)
  }
  else
  {
    common_args_names <- igraph::V(g)[common_args]$name
    val_name <- igraph::V(g)[[val]]$name
    # отдельный узел
    new_node_name <- add_node(c(
      list(
        fun = fun,
        val = val_name,
        name = flat_str(fun, c(val_name, common_args_names))
      ),
      common_args_names
    ))

    common_node_id <- igraph::V(g)[[name == new_node_name]] |> as.integer()
  }
  g <<- igraph::E(g)[.from(c(common_args, val)) & .to(ids)] |>
    igraph::delete_edges(g, edges = _) |>
    igraph::add_edges(rbind(common_node_id, ids), label = 'val')

  purrr::walk2(ids, unique_args, \(id, args) {
    igraph::V(g)$name <<- stringr::str_replace_all(igraph::V(g)$name,
                                                   stringr::str_escape(igraph::V(g)[[id]]$name),
                                                   flat_str(fun, c(igraph::V(g)[[common_node_id]]$name, args)))
  })
}

merge_graph <- function()
{
  repeat
  {
    cmn <- get_common()
    if(nrow(cmn) == 0L)
      break
    purrr::pwalk(cmn, insert_node)
  }
}
