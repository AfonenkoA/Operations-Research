if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL")))
  quit()

out <- Sys.getenv('QUARTO_PROJECT_OUTPUT_DIR')
for(cfg in fs::dir_ls(recurse = TRUE,
                      glob = '*content-export.yml',
                      type = 'file'))
  for(e in yaml::read_yaml(cfg))
    for(f in e$files)
    {
      d <- fs::path_dir(cfg)
      fs::dir_create(out,d)
      fs::file_copy(path = fs::path(d, f),
                    new_path = fs::path(out,d,f),
                    overwrite = TRUE)
    }

