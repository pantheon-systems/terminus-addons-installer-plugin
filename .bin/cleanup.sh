#!/bin/bash
set -ex
PHP_VERSION=$(echo "$PHP_VERSION" | tr -d '.')
# Nuke any lingering multidev environments from orbit.
for ENV in $(terminus multidev:list --field=Name --format=list "$TERMINUS_SITE"); do
  if [[ "$ENV" =~ ^ci-.*-"$PHP_VERSION" || "$ENV" == localtests || "$ENV" =~ ^fs-.*-"$PHP_VERSION" ]]; then
    echo "Deleting $ENV."
	  terminus multidev:delete --delete-branch --yes "${TERMINUS_SITE}"."${ENV}"
  fi
done

echo "✅ Done!"
