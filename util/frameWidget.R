frameWidget <- function(...)
{
  if(!rstudioapi::isAvailable())
  {
    cur_dir <- Sys.getenv('QUARTO_PROJECT_DIR')
    res_file <- fs::path(cur_dir, Sys.getenv('WIDGET_LIST_COPY_FILENAME'))
    knitr::current_input(dir = TRUE) |>
      fs::path_rel(start = cur_dir) |>
      fs::path_ext_remove() |>
      paste0('_files') |>
      fs::path('figure-html','widgets',
               paste0('widget_', knitr::opts_current$get("label"), '.html')) |>
      paste0('\n') |>
      readr::write_file(file = res_file, append = TRUE)
  }

  widgetframe::frameWidget(...)
}
