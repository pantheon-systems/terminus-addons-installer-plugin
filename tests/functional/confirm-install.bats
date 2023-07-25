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
  [[ $output == *"Run a scaffold_extension UJR job"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on addons-install:list command" {
  run terminus help addons-install:list
  [[ $output == *"List the available scaffold_extension UJR jobs"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on addons-install:run command" {
  run terminus help addons-install:run
  [[ $output == *"Run the scaffold_extension UJR job"* ]]
  [ "$status" -eq 0 ]
}
