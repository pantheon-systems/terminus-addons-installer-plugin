#!/bin/bash
set +ex
SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
# TODO: Remove the plugin after it is installed via the workflow.
terminus multidev:delete --delete-branch --yes $SITE_ENV