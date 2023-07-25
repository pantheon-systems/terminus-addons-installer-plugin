#!/usr/bin/env bats

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
