source("renv/activate.R")

options(renv.config.sysreqs.check = FALSE)
invisible(capture.output(st <- renv::status()))

if(!st$synchronized)
    renv::restore()

Sys.setenv(PLOTLY_MATHJAX_PATH=fs::path_abs('mathjax_plotly'))
