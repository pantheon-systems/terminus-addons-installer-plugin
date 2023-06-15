#!/usr/bin/env bats

@test "run scaffold-extension command" {
  run terminus scaffold-extension
  [[ $output == *"Attempting to run scaffold_extension job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold
  [[ $output == *"Attempting to run scaffold_extension job"* ]]
  [ "$status" -eq 0 ]

  run terminus se
  [[ $output == *"Attempting to run scaffold_extension job"* ]]
  [ "$status" -eq 0 ]
}

@test "run scaffold-extension:list command" {
  run terminus scaffold-extension:list foo
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:list foo
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]

  run terminus se:list foo
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:list foo.dev
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:list foo.dev
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]

  run terminus se:list foo.dev
  [[ $output == *"Attempting to list jobs on"* ]]
  [ "$status" -eq 0 ]
}

@test "run scaffold-extension:run command" {
  run terminus scaffold-extension:run foo bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus se:run foo bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold-extension:run foo.dev bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus scaffold:run foo.dev bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]

  run terminus se:run foo.dev bar
  [[ $output == *"Attempting to run the bar job"* ]]
  [ "$status" -eq 0 ]
}

@test "test failure states" {
  run terminus scaffold:run foo
  [[ $output == *"Please provide a job ID"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:run
  [[ $output == *"Not enough arguments"* ]]
  [ "$status" -eq 1 ]

  run terminus scaffold:list
  [[ $output == *"Not enough arguments"* ]]
  [ "$status" -eq 1 ]
}
