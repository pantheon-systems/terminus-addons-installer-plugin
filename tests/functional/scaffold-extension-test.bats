#!/usr/bin/env bats

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
  run terminus scaffold-extension:run foo install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:run foo.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo.dev install_ocp
  [[ $output == *"Attempting to run the install_ocp job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus scaffold:run foo
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run
  [[ $output == *"Please provide site information"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold-extension:run foo bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run foo bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold-extension:run foo.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run foo.dev bar
  [[ $output == *"The bar job does not exist"* ]]
  [ "$status" -eq 1 ]
}
