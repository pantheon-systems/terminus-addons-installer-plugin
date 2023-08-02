#!/usr/bin/env bats

source ./bin/set-up-globals.sh

#
# confirm-install.bats
#
# Ensure that Terminus and the Composer plugin have been installed correctly
#

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

  run echo "$multidev_list" | grep -q "${FS_TEST_ENV}"
  [[ $output == *"Created"* ]]
  [ "$status" -eq 0 ]

  run echo "$multidev_list" | grep -q "${SITE_ENV}"
  [[ $output == *"Created"* ]]
  [ "$status" -eq 0 ]
}