fs::path(Sys.getenv('QUARTO_PROJECT_DIR'),
     Sys.getenv('WIDGET_LIST_COPY_FILENAME')) |>
  fs::file_create()
