#!/bin/bash
set -e

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
terminus multidev:create "$TERMINUS_SITE".dev ci-"$BUILD_NUM"
terminus connection:set "$TERMINUS_SITE".ci-"$BUILD_NUM" git

# Check if ~/.ssh directory exists
if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh
	chmod 700 ~/.ssh
fi

# Check if ~/.ssh/config file exists
if [ ! -f ~/.ssh/config ]; then
	touch ~/.ssh/config
	chmod 600 ~/.ssh/config
fi

{
	echo "Editing the ~/.ssh/config file"
	echo "Host *"
	echo "  StrictHostKeyChecking no"
	echo "  LogLevel ERROR"
	echo "  UserKnownHostsFile /dev/null"
} >> ~/.ssh/config