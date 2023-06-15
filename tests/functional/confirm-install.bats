#!/usr/bin/env bats

#
# confirm-install.bats
#
# Ensure that Terminus and the Composer plugin have been installed correctly
#

@test "confirm terminus version" {
  terminus --version
}

@test "get help on scaffold-extension command" {
  run terminus help scaffold-extension
  [[ $output == *"Run a scaffold extension UJR job"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on scaffold-extension:list command" {
  run terminus help scaffold-extension:list
  [[ $output == *"List the available scaffold_extension UJR jobs"* ]]
  [ "$status" -eq 0 ]
}

@test "get help on scaffold-extension:run command" {
  run terminus help scaffold-extension:run
  [[ $output == *"Run the scaffold_extension UJR job"* ]]
  [ "$status" -eq 0 ]
}
