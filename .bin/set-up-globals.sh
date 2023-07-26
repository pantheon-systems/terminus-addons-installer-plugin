#!/bin/bash
set -ex

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

set +ex
echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
terminus multidev:create $TERMINUS_SITE.dev ci-$BUILD_NUM
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

echo "Editing the ~/.ssh/config file"
# Set StrictHostKeyChecking to no in ~/.ssh/config
echo "StrictHostKeyChecking no" >> ~/.ssh/config
# Set LogLevel to ERROR in ~/.ssh/config
echo "LogLevel ERROR" >> ~/.ssh/config
# Set UserKnownHostsFile to /dev/null in ~/.ssh/config
echo "UserKnownHostsFile /dev/null" >> ~/.ssh/config
# Create the id_rsa file
# echo "Creating the id_rsa file"
# touch ~/.ssh/id_rsa
# echo "$SSH_KEY" > ~/.ssh/id_rsa