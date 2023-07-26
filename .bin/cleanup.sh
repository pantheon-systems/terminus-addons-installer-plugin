#!/bin/bash
set +ex
SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
# Nuke any lingering multidev environments from orbit.
for ENV in $(terminus multidev:list --field=Name --format=list $TERMINUS_SITE); do
  if [[ $ENV == ci-* ]]; then
	terminus multidev:delete --delete-branch --yes ${TERMINUS_SITE}.${ENV}
  fi
  # Also dump any localtests environments.
  if [[ $ENV == localtests ]]; then
	terminus multidev:delete --delete-branch --yes ${TERMINUS_SITE}.localtests
  fi
done
