#!/bin/bash
set -ex

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

set +ex
echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
touch $HOME/.ssh/config
echo "StrictHostKeyChecking no" >> "$HOME/.ssh/config"
# Check if TERMINUS_SITE is not empty.
if [ -z "$TERMINUS_SITE" ]; then
  echo "TERMINUS_SITE is not defined. Please set it to the name of your Pantheon site if needed for this step."
else
  echo "Test site is $TERMINUS_SITE"
  # Make sure the current user has access to the site.
  terminus site:info "$TERMINUS_SITE"
  terminus wp "$TERMINUS_SITE.dev" -- core version
fi