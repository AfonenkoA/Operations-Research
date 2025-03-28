# Не удаляет ./_freeze и ./*-book
find .\
 -name "*_cache"    -type d -o\
 -name "*_freeze"   -type d -o\
 -name "*_files"    -type d -o\
 -name "*-book"     -type d -o\
 -name "*_gen"      -type d\
 -prune -exec rm -rf {} +
rm -rf .quarto
