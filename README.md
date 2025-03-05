# Установка

Установить julia, python, RStudio (не обязательно), Quarto CLI.

``` r
renv::restore()
```

# Конфигурации

Для полного сброса кеша в quarto

``` bash
git clean -fxd
```

Файлы использующие widgetframe обязаны отключать `cache` и `freeze` иначе файлы виджетов не копируются в итоговый каталог.

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
