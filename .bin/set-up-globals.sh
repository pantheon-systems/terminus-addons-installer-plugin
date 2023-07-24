#!/bin/bash
set -ex

TERMINUS_PLUGINS_DIR=.. terminus list -n remote

set +ex
echo "Logging in with a machine token:"
terminus auth:login -n --machine-token="$TERMINUS_TOKEN"
terminus whoami
terminus multidev:create --no-db --no-files $TERMINUS_SITE ci-$BUILD_NUM