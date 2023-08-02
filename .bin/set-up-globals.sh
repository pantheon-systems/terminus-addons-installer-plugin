#!/bin/bash
set -e

# Trim the newline character from BUILD_NUM variable
BUILD_NUM=$(echo "${BUILD_NUM}" | tr -d '\n')

# Check if TERMINUS_SITE is defined, otherwise define it as terminus-addons-installer-plugin.
if [ -z "$TERMINUS_SITE" ]; then
  # Looks like this is a local run. We'll create the localtests multidev to test this.
  TERMINUS_SITE=terminus-addons-installer-plugin

  # Check if the localtests environment exists already, otherwise create it. This can be passed locally as an environment variable but defaults to localtests.
  if [ -z "$LOCALENV" ]; then
    LOCALENV=localtests
  fi

  output=$(terminus multidev:list "$TERMINUS_SITE" || true)
  if ! echo "$output" | grep -q "${LOCALENV}"; then
    terminus multidev:create "$TERMINUS_SITE".dev "$LOCALENV"
  fi
  SITE_ENV="${TERMINUS_SITE}.${LOCALENV}"
  FS_TEST_ENV="${TERMINUS_SITE}.fs-test"

  # If we're in a local run, let's create and set up the multidev early. On CI runs, we do this in set-up-globals.sh.
  # Create a new multidev just for this failure test
  terminus multidev:create "$TERMINUS_SITE".dev fs-test

  # Switch to SFTP mode.
  terminus connection:set "$FS_TEST_ENV" sftp

  # Install the Hello Dolly plugin.
  terminus wp "$FS_TEST_ENV" -- plugin install hello-dolly
else
  # Always use the multidev if in CI.
  SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
  FS_TEST_ENV="${TERMINUS_SITE}.fs-test-${BUILD_NUM}"
fi

# Echo the newly created globals.
echo "SITE_ENV: ${SITE_ENV}"
echo "FS_TEST_ENV: ${FS_TEST_ENV}"