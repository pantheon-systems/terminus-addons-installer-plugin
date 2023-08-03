#!/bin/bash
set -e

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

# Set the fs-test number. If the build number is > 999, we need to trim the -test- out of the middle.
if [ "$BUILD_NUM" -gt 999 ]; then
	FS_TEST="fs-${BUILD_NUM}"
else
	FS_TEST="fs-test-${BUILD_NUM}"
fi

echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
terminus multidev:create "$TERMINUS_SITE".dev ci-"$BUILD_NUM"
terminus connection:set "$TERMINUS_SITE".ci-"$BUILD_NUM" git
# Set up the environment for filesystem tests.
terminus multidev:create "$TERMINUS_SITE".dev "$FS_TEST"
terminus connection:set "$TERMINUS_SITE"."$FS_TEST" sftp

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

terminus wp "$TERMINUS_SITE"."$FS_TEST" -- plugin install hello-dolly