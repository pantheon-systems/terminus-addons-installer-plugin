#!/usr/bin/env bats

# Check if TERMINUS_SITE is defined, otherwise define it as terminus-addons-installer-plugin.
if [ -z "$TERMINUS_SITE" ]; then
  TERMINUS_SITE=terminus-addons-installer-plugin
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
  run terminus addons-install:run ${TERMINUS_SITE} install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus install:run ${TERMINUS_SITE} install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus addons-install:run ${TERMINUS_SITE}.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus install:run ${TERMINUS_SITE}.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus install:run ${TERMINUS_SITE}
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run
  [[ $output == *"Please provide site information"* ]]
  [ "$status" -eq 1 ]

  run terminus addons-install:run ${TERMINUS_SITE} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run ${TERMINUS_SITE} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus addons-install:run ${TERMINUS_SITE}.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus install:run ${TERMINUS_SITE}.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]
}
