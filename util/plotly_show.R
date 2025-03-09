loadNamespace('webshot2')
loadNamespace('widgetframe')
loadNamespace('htmlwidgets')
loadNamespace('reticulate')
loadNamespace('fs')

show_non_html <- function(fig)
{
  dir_name <- knitr::current_input() |> fs::path_ext_remove() |> paste0('_gensvg_flcs')
  fig_name <- paste0(knitr::opts_current$get("label"), '.svg')
  fig_path <- fs::path(dir_name, fig_name)
  fs::dir_create(dir_name)

  fig |>
  plotly::save_image(fig_path) |>
  knitr::include_graphics()
}

pshow_safe <- function(fig)
{
  if(interactive())
    return(fig)
  if(knitr::is_html_output())
    return(widgetframe::frameWidget(fig))
  else
    return(show_non_html(fig))
}

pshow_protected <- function(fig)
{
  if(interactive())
    return(fig)
  if(knitr::is_html_output())
    return(widgetframe::frameableWidget(fig))
  else
    return(show_non_html(fig))
}

pshow <- function(fig)
{
  if(interactive())
    return(fig)
  if(knitr::is_html_output())
    return(fig)
  else
    return(show_non_html(fig))
}
