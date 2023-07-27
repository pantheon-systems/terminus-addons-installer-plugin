#!/bin/bash
set -ex

# Nuke any lingering multidev environments from orbit.
for ENV in $(terminus multidev:list --field=Name --format=list "$TERMINUS_SITE"); do
  if [[ "$ENV" == ci-"$BUILD_NUM" || "$ENV" == localtests || "$ENV" == fs-test* ]]; then
	terminus multidev:delete --delete-branch --yes "${TERMINUS_SITE}"."${ENV}"
  fi
done
