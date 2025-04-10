interp <- function(z)
{
  d <- attributes(z)$dim - 1
  x <- seq(-d[[1]] / 2, d[[1]] / 2, by = 1)
  y <- seq(-d[[1]] / 2, d[[1]] / 2, by = 1)
  function(p)
    pracma::interp2(x, y, z, p[[1]], p[[2]])
}

add_segments <- function(fig, t, a, p)
{
  ind <- which(a - p > 0)
  g <- which(diff(ind) != 1)
  purrr::reduce2(
    c(1, g + 1),
    c(g, length(ind)),
    \(fig, from, to) plotly::add_trace(
      fig,
      x = t[ind[from:to]],
      y = p[ind[from:to]],
      name = 'экр',
      line = list(color = 'red')
    ),
    .init = fig
  )
}
