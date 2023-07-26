#!/usr/bin/env bats

# Check if TERMINUS_SITE is defined, otherwise define it as terminus-addons-installer-plugin.
if [ -z "$TERMINUS_SITE" ]; then
  TERMINUS_SITE=terminus-addons-installer-plugin
  terminus multidev:create $TERMINUS_SITE.dev localtests
  SITE_ENV="${TERMINUS_SITE}.localtests"
else
  # Always use the multidev if in CI.
  SITE_ENV="${TERMINUS_SITE}.ci-${BUILD_NUM}"
fi

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
  run terminus addons-install:run ${SITE_ENV} install_ocp
  [[ $output == *"Attempting to run the install-ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus install:run ${SITE_ENV} install_ocp
  [[ $output == *"Attempting to run the install-ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus addons-install:run ${SITE_ENV} install-ocp
  [[ $output == *"Attempting to run the install-ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus install:run ${SITE_ENV} install-ocp
  [[ $output == *"Attempting to run the install-ocp job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus install:run ${SITE_ENV}
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run
  [[ $output == *"Please provide site information"* ]]
  [ "$status" -eq 1 ]

  run terminus addons-install:run ${SITE_ENV} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run ${SITE_ENV} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]
}

@test "test failure state if command is run with uncommitted filesystem changes" {
  echo "Set up failure state with uncommitted filesystem changes"
  [ "$status" -eq 0 ]
  echo "Running terminus wp ${SITE_ENV} -- plugin install hello-dolly"
  run terminus wp ${SITE_ENV} -- plugin install hello-dolly
  [ "$status" -eq 0 ]
  run terminus install:run ${SITE_ENV} install-ocp
  [[ $output == *"Please commit or revert them before running this job"* ]]
  [ "$status" -eq 1 ]
}
