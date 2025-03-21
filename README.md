# Установка

Установить julia, python, RStudio (не обязательно), Quarto CLI, texlive. Дополнительная зависимость gdal, asymptote, libunits2

``` r
renv::restore()
```

В случае ошибки установить параметр

``` r
options(renv.config.sysreqs.check = FALSE)
```

# Конфигурации

Для полного сброса кеша в quarto

``` bash
git clean -fxd
```

Файлы использующие widgetframe обязаны отключать `cache` и `freeze` иначе файлы виджетов не копируются в итоговый каталог.

## Обновить пакеты

### R

``` r
renv::update()
```

### Python

``` bash
pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip install -U
```

### Julia

``` bash
julia --project=.
```

``` julia
]
update
```

## Методичка

### pdf

``` bash
quarto render --to pdf --profile student,dev,pdf
```

### html

``` bash
quarto render --to html --profile student,dev,html
```

## Методичка и проверочные работы с решениями

### pdf

``` bash
quarto render --to pdf --profile full,dev,pdf
```

### html

``` bash
quarto render --to html --profile full,dev,html
```

## Проверочные работы

### pdf

``` bash
quarto render --to pdf --profile dev,exam,pdf-exam
```

### html

``` bash
quarto render --to html --profile dev,exam,html
```

## Подсчёт строк кода

``` bash
cloc --vcs=git --read-lang-def=cloc-qmd-lang-def --exclude-ext=json,svg --exclude-dir=renv
```
