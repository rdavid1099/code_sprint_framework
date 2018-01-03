#!/usr/bin/env bats

load test_helper

setup()
{
  export ENV='test'
  export PARENT_PATH=$PWD
}

@test "it assigns default values if no params are passed" {
  run bash $NEW

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building JavaScript sprint named simple_sprint" ]
}

@test "it assigns language value when proper flag is passed" {
  run bash $NEW --language=ruby

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building Ruby sprint named simple_sprint" ]  
}
