if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL")))
  quit()

profiles <- Sys.getenv('QUARTO_PROFILE') |> stringr::str_split_1(',')
groups <- yaml::read_yaml('_quarto.yml')$profile$group

cat('Профили: ', toString(profiles),'\n')

res <- sapply(groups,\(g) sapply(profiles,\(p) p %in% g))

if(length(profiles) != length(groups))
  stop('Колличество профилей и групп не совпадает')

for(i in seq_len(nrow(res)))
  if(sum(res[i,]) != 1L)
    stop(paste0('Неизвестный профиль "',dimnames(res)[[1]][[i]],'"\n'))
