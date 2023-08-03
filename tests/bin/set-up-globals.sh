#!/bin/bash
set -e

# Trim the newline character from BUILD_NUM variable
BUILD_NUM=$(echo "${BUILD_NUM}" | tr -d '\n')

create_multidev() {
  local site="$1"
  local env="$2"
  local force="$3" || false

  if [ "$force" = true ]; then
    echo "Creating multidev $env for $site without checking if it exists first."
    terminus multidev:create "$site".dev "$env"
    return
  fi

  output=$(terminus multidev:list "$site" || true)
  if ! echo "$output" | grep -q "$env"; then
    echo "$env does not exist. Creating multidev $env for $site."
    terminus multidev:create "$site".dev "$env"
  fi
}

switch_to_git_mode() {
  local env="$1"
  echo "Switching to git mode for $env."
  terminus connection:set "$env" git --yes
}

switch_to_sftp_mode() {
  local env="$1"
  echo "Switching to SFTP mode for $env."
  terminus connection:set "$env" sftp
}

install_hello_dolly() {
  local env="$1"
  output=$(terminus wp "$env" -- plugin list || true)
  if ! echo "$output" | grep -q "hello-dolly"; then
    echo "Installing Hello Dolly plugin on $env."
    terminus wp "$env" -- plugin install hello-dolly
  fi
}

# Helper function to turn debug mode on for tests.
# Usage: debug <command to test> <args>
# Example: debug terminus install:run "$SITE_ENV" ocp
debug() {
  (set -x; run "$@"; set +x)
}

# Check if TERMINUS_SITE is defined, otherwise define it as terminus-addons-installer-plugin.
if [ -z "$TERMINUS_SITE" ]; then
  # Looks like this is a local run. We'll create the localtests multidev to test this.
  echo "TERMINUS_SITE not defined. Defining as terminus-addons-installer-plugin."
  TERMINUS_SITE=terminus-addons-installer-plugin

  # Check if the localtests environment exists already, otherwise create it. This can be passed locally as an environment variable but defaults to localtests.
  if [ -z "$LOCALENV" ]; then
    echo "LOCALENV not defined. Defining as localtests."
    LOCALENV=localtests
  fi

  create_multidev "$TERMINUS_SITE" "$LOCALENV"

  SITE_ENV="${TERMINUS_SITE}.${LOCALENV}"
  FS_TEST_ENV="${TERMINUS_SITE}.fs-test"
  echo "SITE_ENV is $SITE_ENV"
  echo "FS_TEST_ENV is $FS_TEST_ENV"

  if ! echo "$output" | grep -q "fs-test"; then
    create_multidev "$TERMINUS_SITE" "fs-test" true
  else
    switch_to_git_mode "$FS_TEST_ENV"
  fi

  switch_to_sftp_mode "$FS_TEST_ENV"
  install_hello_dolly "$FS_TEST_ENV"
else
  # Always use the multidev if in CI.
  SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
  FS_TEST_ENV="${TERMINUS_SITE}.fs-test-${BUILD_NUM}"
  echo "SITE_ENV is $SITE_ENV"
  echo "FS_TEST_ENV is $FS_TEST_ENV"
fi

# Set the environment variables for the tests.
export TERMINUS_SITE
export SITE_ENV
export FS_TEST_ENV