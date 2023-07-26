#!/bin/bash
set +ex
SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
# Switch back to Git mode after functional tests switched to SFTP.
terminus connection:set $SITE_ENV git --yes
# Delete the multidev environment.
terminus multidev:delete --delete-branch --yes $SITE_ENV