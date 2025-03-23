if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL")))
  quit()

profiles <- Sys.getenv('QUARTO_PROFILE') |> stringr::str_split_1(',')
groups <- yaml::read_yaml('_quarto.yml')$profile$group

cat('Профили: ', toString(profiles), '\n')

res <- sapply(groups, \(g) sapply(profiles, \(p) p %in% g))

if (length(profiles) != length(groups))
  stop('Колличество профилей и групп не совпадает')

for (i in seq_len(nrow(res)))
  if (sum(res[i, ]) != 1L)
    stop(paste0('Неизвестный профиль "', dimnames(res)[[1]][[i]], '"\n'))

re <- r'(:::\s+\{\.content-(?:hidden|visible)\s+(?:when|unless)\-profile=\"?(?<profile>[^\"]+)\"?.+\})'
in_text_profiles <- fs::dir_ls(type = 'file',
                               glob = '*.qmd',
                               recurse = TRUE) |>
  purrr::map_chr(readr::read_file) |>
  stringr::str_match_all(stringr::regex(re)) |>
  (\(l) l[!purrr::map_lgl(l, rlang::is_empty)])() |>
  do.call(rbind, args = _) |>
  (\(m) m[, 2])() |>
  unique()

all_profiles <- unlist(groups)

for (p in in_text_profiles)
  if (!(p %in% all_profiles))
    stop(paste0('Неизвестный профиль "', p, '"\n'))
