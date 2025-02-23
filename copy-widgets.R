library(fs)
library(purrr)
library(readr)


out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')

cp <- function(cur_path)
{
  new_path <- path(out, cur_path)
  new_path |> path_dir() |> dir_create()
  depth <- path_split(cur_path)[[1]] |> length()
  read_file(cur_path) |>
    gsub(pattern = 'plotly_libs', replacement = '/Operations-Research/site_libs', x=_) |>
    write_file(file = new_path)
}

dir_ls(recurse = TRUE, type = "file") |>
  path_filter(glob = '*_files/figure-html/widgets/widget_*.html') |>
  discard(\(p) grepl('unconstrained/analytical-many', p)) |>
  walk(cp)
