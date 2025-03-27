library(fs)
library(purrr)
library(readr)
library(stringr)

if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL")))
  quit()

site_libs_dir <- Sys.getenv('SITE_LIBS_PATH')

out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')

proj_profiles <- Sys.getenv('QUARTO_PROFILE') |> str_split_1(',')
proj_abs_paths <- list('dev' = path_abs(out),
                       'prod' = Sys.getenv('PROJECT_PATH'))

is_dev <- 'dev' %in% proj_profiles

proj_abs_path <- proj_abs_paths[[intersect(names(proj_abs_paths), proj_profiles)]]

file_string_replace <- function(p, pattern, replacement)
{
  read_file(p) |>
    gsub(pattern = pattern, replacement = replacement, x=_) |>
    write_file(p)
}
