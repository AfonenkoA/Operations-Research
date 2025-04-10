# Выбор цветов для градиента
plt <- c('red', 'green')

# Создать функцию по палитре. clf получает число цветов и равномерно распределяет градиент между ними
clf <- colorRampPalette(plt)

# Выбрать из датафрейма строки равномерно длиной n и добавить колонку цвета
uni_colored_sample <- \(df, n) dplyr::slice(df, seq(1, nrow(df), length.out = n) |> as.integer()) |>
  tibble::add_column(color = clf(n))

# Выбрать из датафрейма строки логарифмически (в начале больше) длиной n и добавить колонку цвета
log_colored_sample <- \(df, n) dplyr::slice(df, pracma::logseq(1, nrow(df), n) |> round()) |>
  tibble::add_column(color = clf(n))

# Выбрать из датафрейма строки логарифмически (в конце больше) длиной n и добавить колонку цвета
rlog_colored_sample <- \(df, n) dplyr::slice(df, nrow(df) + 1  - pracma::logseq(nrow(df), 1, n) |> round()) |>
  tibble::add_column(color = clf(n))

# Аналог base::outer для не векторизированной функции smoof
# Возвращает список, с векторами координат x1,x2,x3,...,xn длинами len[[1]],len[[2]],...,len[[n]]
# Элемент Z содержит массив со значениями функции f на координатной сетке, размера len[[1]]*len[[2]]*...*len[[n]]
smoof_outer <- function(f, len)
{
  n <- smoof::getNumberOfParameters(f)
  len <- if(length(len) == 1) rep(len, n) else len
  lo <- smoof::getLowerBoxConstraints(f)
  up <- smoof::getUpperBoxConstraints(f)
  x <- purrr::pmap(list(lo, up, len), \(l, u, le) seq(l, u, length.out = le)) |>
    purrr::set_names(paste0('x', seq_len(n)))
  cf <- purrr::compose(f, c)
  z <- do.call(tidyr::crossing, rev(x)) |>
    purrr::pmap_dbl(cf)
  attributes(z)$dim <- len
  x$z <- z
  x
}

# Вызывает библиотеку plot_ly для отрисовки контурного графика для функции smoof
pcontour <- function(f, len)
{
  df <- smoof_outer(f, len)
  plotly::plot_ly(x = df$x1, y = df$x2, z = df$z, type = 'contour')
}

# Добавляет на (контурный) график точки из датасета. Точки выделюятся цветом, если датасет df получен с помощью функций *_colored_sample
add_path_points <- \(fig, df) plotly::add_trace(fig, x = df$x1, y = df$x2, type = 'scatter', mode = 'markers', color = df$color, showlegend = FALSE)
