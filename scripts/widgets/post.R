library(fs)
library(purrr)
library(readr)

out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')
cur_dir <- Sys.getenv('QUARTO_PROJECT_DIR')
res_file <- path(cur_dir, Sys.getenv('WIDGET_LIST_COPY_FILENAME'))

lib_path <- switch(Sys.getenv('QUARTO_PROFILE'),
                   'production' = Sys.getenv('PROJECT_PATH'),
                   'development' = fs::path_abs(cur_dir)) |>
  fs::path(Sys.getenv('SITE_LIBS_PATH'))

cp <- function(rel_path)
{
  new_path <- path(out, rel_path)
  new_path |> path_dir() |> dir_create()
  path(cur_dir,rel_path) |>
    read_file() |>
    gsub(pattern = 'plotly_libs', replacement = lib_path, x=_) |>
    write_file(file = new_path)
}

walk(read_lines(res_file), cp)
fs::file_delete(res_file)
