# Замечания {.unnumbered}

## Содержательные

-   [ ] В первой лабораторной не существует функции `inverse`, использовать `solve`
-   [ ] RScript не добавляется в \$PATH по умолчанию на Windows
-   [ ] Низкое качество `.png` картинок в лабораторных и проверочных, заменить на соответствующие векторные форматы.
-   [ ] Рисунок с подсказкой в задаче **Авиа-билеты** и **Пилорама**
-   [ ] Добавить больше примеров в раздел векторизации языка R, не только встроенные операторы
-   [ ] Добавить пример оформления отчётов, принципы хорошего стиля интерактивных блокнотов для лабораторных.
-   [ ] В графических заданиях по линейному программированию явно прописать, что на рисунке надо подписывать ограничения и целевую функцию
-   [ ] Привести практические и тестовые к системе уровней
-   [ ] В целочисленном программировании для иллюстрации метода ветвей и границ построить дерево решений через диаграмму mermaid
-   [ ] Привести метод гаусса в векторном псевдокоде
-   [ ] Явно прописать, что при решении задач формулы приводятся как `latex`
-   [ ] Диаграмма типов данных и отношение между ними в R, а также графические примеры списка, вектора, матрицы. Тоже самое как в шпаргалке по purrr.

## Технические

-   [ ] Добавить отладочную версию скриптов подстановки ссылок (печать промежуточных действий на экран)
-   [ ] Стандартизировать скрипты проекта на R (общий стиль, общее подгружаемое окружение, комментарии и документация).
-   [ ] Интерфейсы к `python`, `julia`, `octave` и `haskell`
-   [ ] Связать примеры задач в теме линейного программирования с разбором этих задач в решателях. Возможно через обобщение или через сохранение в специфическом формате.
-   [ ] В `r-tools` использовать `code-link` в отдельных блоках кода, а не на весь файл.
-   [ ] При приведении задач из книжек и ресурсов использовать сущности `inbook` в `ref.bib`
-   [ ] Оптимизация размера html страницы. Функция `add_region` вызывает TeX только при необходимости.
-   [ ] В практических и экзаменационных работах отключить нумерацию разделов
-   [ ] Рассмотреть использование <https://github.com/quarto-ext/fontawesome>
-   [ ] Упростить структуру документов лабораторных, практических и проверочных работ. Использовать пользовательский атрибуты блоков что снизить сложность исходников. Обработку реализовать через фильтры lua в pandoc
-   [ ] В лабораторных, практических и экзаменационных работах организовать структуры с выносом текста задач в каталог `problems`, решений в `solutions`
-   [ ] Документация общих принципов построения разделов, практических, лабораторных. Отметить нюансы, ошибки и костыли
-   [ ] Создание вариантов лабораторных на основе подставляемых параметров. В `html` генератор через имя студента. Возможно просто менять числа, возможно выбирать задания из объема. В `PDF` просто список готовых вариантов
-   [ ] Рассмотреть именованные листинги
-   [ ] Тренажёры по алгоритмам. Линейное программирование анализ чувствительности, симплекс метод. Нелинейные алгоритмы. Возможно алгоритмы на графах.
-   [ ] Обобщить подстановку картинок в форматах SVG/pdf использовав ручной конвертер.
-   [ ] Рассмотреть возможность использования PGF/Tikz для 2D и 3D сцен
-   [ ] Русский шрифт не отображается на в названиях вершин `igraph` при отображении в PDF
