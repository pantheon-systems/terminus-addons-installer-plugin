set -e
source_path=tests/bin/set-up-globals.sh
if [ -n "$GITHUB_WORKSPACE" ]; then
    echo "Running in GitHub workflow. Setting up globals."
    source_path="$GITHUB_WORKSPACE/$source_path"
fi

. "$source_path"

TERMINUS_PLUGINS_DIR=.. PATH=tools/bin:$PATH bats -p -t tests/functional