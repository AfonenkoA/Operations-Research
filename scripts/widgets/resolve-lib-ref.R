source('scripts/load_enviroment.R')

fs::dir_ls(out, recurse = TRUE, glob = '*_files/figure-html/widgets/widget_*.html', type = 'file') |>
  purrr::walk(file_string_replace, pattern = 'plotly_libs', replacement = site_lib_path)

fs::dir_ls(out, recurse = TRUE, glob = '*plotly_libs', type = 'dir') |>
  purrr::walk(dir_delete)
