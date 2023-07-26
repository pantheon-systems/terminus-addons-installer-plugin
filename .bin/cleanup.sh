#!/bin/bash
set +ex
SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
# Delete the multidev environment.
terminus multidev:delete --delete-branch --yes $SITE_ENV