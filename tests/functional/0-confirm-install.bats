#!/usr/bin/env bats

# Helper function to turn debug mode on for tests.
# Usage: debug <command to test> <args>
# Example: debug terminus install:run "$SITE_ENV" ocp
debug() {
  (set -x; run "$@"; set +x)
}

#
# confirm-install.bats
#
# Ensure that Terminus and the Composer plugin have been installed correctly
#

@test "check globals" {
  run echo "TERMINUS_SITE: ${TERMINUS_SITE}"
  [[ $output == *"TERMINUS_SITE: ${TERMINUS_SITE}"* ]]

  run echo "SITE_ENV: ${SITE_ENV}"
  [[ $output == *"SITE_ENV: ${SITE_ENV}"* ]]

  run echo "FS_TEST_ENV: ${FS_TEST_ENV}"
  [[ $output == *"FS_TEST_ENV: ${FS_TEST_ENV}"* ]]
}

@test "confirm terminus version" {
  terminus --version
}

@test "get help on addons-install command" {
  run terminus help addons-install
  [[ $output == *"Run a specified job"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on addons-install:list command" {
  run terminus help addons-install:list
  [[ $output == *"List the available jobs"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on addons-install:run command" {
  run terminus help addons-install:run
  [[ $output == *"Run the specified job"* ]]
  [ "$status" -eq 0 ]
}

@test "make sure multidevs were created successfully" {
  multidev_list=$(terminus multidev:list "$TERMINUS_SITE" || true)

  fstest_exists=$(echo "$multidev_list" | grep -q "${FS_TEST_ENV}" || true)
  debug echo fstest_exists
  [[ $output == *"Created"* ]]
  [ $status -eq 0 ]

  siteenv_exists=$(echo "$multidev_list" | grep -q "${SITE_ENV}" || true)
  run echo siteenv_exists
  [[ $output == *"Created"* ]]
  [ $status -eq 0 ]
}