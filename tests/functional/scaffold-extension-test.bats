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
  run terminus scaffold-extension:list foo
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:list foo
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:list foo.dev
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:list foo.dev
  [[ $output == *"Listing available jobs..."* ]]
  [ "$status" -eq 0 ]
}

@test "run scaffold-extension:run command" {
  run terminus scaffold-extension:run foo bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:run foo.dev bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo.dev bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus scaffold:run foo
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run
  [ "$status" -eq 1 ]

  run terminus scaffold:list
  [ "$status" -eq 1 ]
}
