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

site_libs_dir <- 'site_libs'

out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')
proj_dir <- Sys.getenv('QUARTO_PROJECT_ROOT')

proj_profiles <- Sys.getenv('QUARTO_PROFILE') |> str_split_1(',')
proj_abs_paths <- list('dev' = path_abs(out),
                       'prod' = Sys.getenv('PROJECT_PATH'))

proj_abs_path <- proj_abs_paths[[intersect(names(proj_abs_paths), proj_profiles)]]
site_lib_path <-path(proj_abs_path, site_libs_dir)

file_string_replace <- function(p, pattern, replacement)
{
  read_file(p) |>
    gsub(pattern = pattern, replacement = replacement, x=_) |>
    write_file(p)
}
