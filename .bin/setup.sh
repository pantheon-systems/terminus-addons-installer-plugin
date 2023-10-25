#!/bin/bash
set -e

echo "Running PHP $PHP_VERSION tests..."

PHP_VER="$PHP_VERSION"
PHP_VERSION=$(echo "$PHP_VERSION" | tr -d '.')
FS_TEST="fs-${BUILD_NUM}-${PHP_VERSION}"
CI_TEST="ci-${BUILD_NUM}-${PHP_VERSION}"

# Update Terminus to the latest version.
terminus self:update

echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
echo "Creating multidev environments for testing."
terminus multidev:create "$TERMINUS_SITE".dev "$CI_TEST"
terminus connection:set "$TERMINUS_SITE"."$CI_TEST" git
# Set up the environment for filesystem tests.
terminus multidev:create "$TERMINUS_SITE".dev "$FS_TEST"
terminus connection:set "$TERMINUS_SITE"."$FS_TEST" sftp
echo "✅ Created $CI_TEST and $FS_TEST."

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
{
	echo "Host *"
	echo "  StrictHostKeyChecking no"
	echo "  LogLevel ERROR"
	echo "  UserKnownHostsFile /dev/null"
} >> ~/.ssh/config
echo "✅ Done!"

echo "When PHP 8.3 is available on the platform, we will update the pantheon.yml to set the multidev environment to $PHP_VER to validate that the command runs on the platform with the approprate PHP version. For now, we're only running the command on whatever PHP version the fixture site is running."

terminus wp "$TERMINUS_SITE"."$FS_TEST" -- plugin install hello-dolly

export FS_TEST
export CI_TEST

echo "✅ Done setting up $PHP_VER environments!"