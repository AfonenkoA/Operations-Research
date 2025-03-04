Для полного сброса кеша в quarto

``` bash
git clean -fxd
```

``` r
renv::restore()
```

Файлы использующие widgetframe обязаны отключать `cache` и `freeze` иначе файлы виджетов не копируются в итоговый каталог.
