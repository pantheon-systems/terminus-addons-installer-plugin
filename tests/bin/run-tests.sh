source_path=tests/bin/set-up-globals.sh
if [ -n "$GITHUB_WORKSPACE" ]; then
    echo "Running in GitHub workflow. Setting up globals."
    source_path="$GITHUB_WORKSPACE/$source_path"
fi
echo "Source path: $source_path"

if [ -f "$source_path" ]; then
    echo "Sourcing $source_path"
    source "$source_path"
else
    echo "ERROR: File not found at $source_path"
    exit 1
fi

TERMINUS_PLUGINS_DIR=.. PATH=tools/bin:$PATH bats -p -t tests/functional