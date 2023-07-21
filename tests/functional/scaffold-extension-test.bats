#!/usr/bin/env bats

# Check if TERMINUS_SITE is defined, otherwise define it as terminus-addons-installer-plugin.
if [ -z "$TERMINUS_SITE" ]; then
  TERMINUS_SITE=terminus-addons-installer-plugin
fi

@test "run scaffold-extension command" {
  run terminus scaffold-extension
  [[ $output == *"terminus scaffold-extension"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold
  [[ $output == *"terminus scaffold-extension"* ]]
  [ "$status" -eq 0 ]
}

@test "run scaffold-extension:list command" {
  run terminus scaffold-extension:list
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:list
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]
}

@test "run scaffold-extension:run command" {
  run terminus scaffold-extension:run ${TERMINUS_SITE} install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run ${TERMINUS_SITE} install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:run ${TERMINUS_SITE}.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run ${TERMINUS_SITE}.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus scaffold:run ${TERMINUS_SITE}
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run
  [[ $output == *"Please provide site information"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold-extension:run ${TERMINUS_SITE} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run ${TERMINUS_SITE} bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold-extension:run ${TERMINUS_SITE}.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run ${TERMINUS_SITE}.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]
}
