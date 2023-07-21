#!/bin/bash
set -ex

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

set +ex
echo "Test site is $TERMINUS_SITE"
echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
