source_path=tests/bin/set-up-globals.sh
if [ -n "$GITHUB_WORKFLOW" ]; then
	echo "Running in GitHub workflow. Setting up globals."
	source_path="$GITHUB_WORKFLOW"/tests/bin/set-up-globals.sh
fi
source $source_path
TERMINUS_PLUGINS_DIR=.. PATH=tools/bin:$PATH bats -p -t tests/functional