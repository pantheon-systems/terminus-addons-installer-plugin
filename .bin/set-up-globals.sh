#!/bin/bash
set -ex

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

set +ex
echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
terminus multidev:create --no-db --no-files $TERMINUS_SITE.dev ci-$BUILD_NUM
terminus connection:set $TERMINUS_SITE.ci-$BUILD_NUM git
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

# Set StrictHostKeyChecking to no in ~/.ssh/config
echo "StrictHostKeyChecking no" >> ~/.ssh/config
# Set LogLevel to ERROR in ~/.ssh/config
echo "LogLevel ERROR" >> ~/.ssh/config
# Set UserKnownHostsFile to /dev/null in ~/.ssh/config
echo "UserKnownHostsFile /dev/null" >> ~/.ssh/config
# Create the id_ed25519 file
touch ~/.ssh/id_ed25519
echo "$SSH_KEY" > ~/.ssh/id_ed25519