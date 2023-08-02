#!/usr/bin/env bats

load ${GITHUB_WORKSPACE}/.bin/set-up-globals.sh

#
# confirm-install.bats
#
# Ensure that Terminus and the Composer plugin have been installed correctly
#

@test "check globals" {
  echo "SITE_ENV: '${SITE_ENV}'"
  echo "FS_TEST_ENV: '${FS_TEST_ENV}'"
  # Add dummy assertion (true) to make it a valid Bats test
  true
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
  [[ $fstest_exists == *"Created"* ]]
  [ "$status" -eq 0 ]

  siteenv_exists=$(echo "$multidev_list" | grep -q "${SITE_ENV}" || true)
  [[ $siteenv_exists == *"Created"* ]]
  [ "$status" -eq 0 ]
}