#!/usr/bin/env bats

# Helper function to turn debug mode on for tests.
# Usage: debug <command to test> <args>
# Example: debug terminus install:run "$SITE_ENV" ocp
debug() {
  (set -x; run "$@"; set +x)
}

@test "run addons-install command" {
  run terminus addons-install
  [[ $output == *"terminus addons-install"* ]]
  [ "$status" -eq 0 ]

  run terminus install
  [[ $output == *"terminus addons-install"* ]]
  [ "$status" -eq 0 ]
}

@test "run addons-install:list command" {
  run terminus addons-install:list
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]

  run terminus install:list
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]
}

@test "run addons-install:run command" {
  run terminus addons-install:run "$SITE_ENV" ocp
  [[ $output == *"Attempting to run the ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus install:run "$SITE_ENV" ocp
  [[ $output == *"Attempting to run the ocp job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus install:run "$SITE_ENV"
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run
  [[ $output == *"Please provide site information"* ]]
  [ "$status" -eq 1 ]

  run terminus addons-install:run "$SITE_ENV" bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run "$SITE_ENV" bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run "$TERMINUS_SITE".test ocp
  [[ $output == *"You cannot run the ocp workflow in a test environment"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run "$TERMINUS_SITE".live ocp
  [[ $output == *"You cannot run the ocp workflow in a live environment"* ]]
  [ "$status" -eq 1 ]
}

@test "test failure state if command is run with uncommitted filesystem changes" {
  # Run the ocp job on the fs-test environment we created earlier. We expect this to fail because we made changes to the filesystem.
  run terminus install:run "$FS_TEST_ENV" ocp
  [[ $output == *"Please commit or revert them before running this job."* ]]
  [ "$status" -eq 1 ]
}
