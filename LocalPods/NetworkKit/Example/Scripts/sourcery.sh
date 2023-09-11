export PATH="$PATH:/opt/homebrew/bin/"

cd "$PROJECT_DIR/Scripts"
echo "$PWD"
sourcery --config .sourcery.yml --verbose
