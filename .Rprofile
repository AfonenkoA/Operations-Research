source('renv/activate.R')

options(renv.config.sysreqs.check = FALSE)
invisible(capture.output(st <- renv::status()))

if(!st$synchronized)
    renv::restore()
rm(st)

fs::dir_ls(path = 'util', type='file', glob = '*.R') |>
  purrr::walk(source)

Sys.setenv(PLOTLY_MATHJAX_PATH=fs::path_abs('mathjax_plotly'))
