library(fs)
library(purrr)
library(readr)
library(stringr)


if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL")))
  quit()

has_html_out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_FILES') |>
  stringr::str_split_1('\\\\') |>
  path_ext() |>
  unique() |>
  is.element('html', set=_)

if(!has_html_out)
  quit()

out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')
prof <- Sys.getenv('QUARTO_PROFILE') |> str_split_1(',')
prof_path <- list('dev' = path_abs(out),
     'prod' = Sys.getenv('PROJECT_PATH'))

lib_path <- prof_path[[intersect(names(prof_path), prof)]] |>
  path(Sys.getenv('SITE_LIBS_PATH'))

substitue_lib_path <- function(p)
{
    read_file(p) |>
    gsub(pattern = 'plotly_libs', replacement = lib_path, x=_) |>
    write_file(p)
}

dir_ls(out, recurse = TRUE, glob = '*_files/figure-html/widgets/widget_*.html', type = 'file') |>
  walk(substitue_lib_path)

dir_ls(out, recurse = TRUE, glob = '*plotly_libs', type = 'dir') |>
  walk(dir_delete)
