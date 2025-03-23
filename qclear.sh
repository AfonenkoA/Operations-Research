find . -name "*_cache" -type d -prune -exec rm -rf {} +
find . -name "*_freeze" -type d -prune -exec rm -rf {} +
find . -name "*_files" -type d -prune -exec rm -rf {} +
rm -rf .quarto
