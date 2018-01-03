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

@test "it assigns language value when --language flag is passed" {
  run bash $NEW --language=ruby

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building Ruby sprint named simple_sprint" ]
}

@test "it assigns language value when -l flag is passed" {
  run bash $NEW -l python

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building Python sprint named simple_sprint" ]
}

@test "it throws error with unsupported languages" {
  run bash $NEW -l golang

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Unsupported language 'golang' passed. Please pass a supported language." ]
}

@test "it throws error when multiple languages are passed" {
  run bash $NEW -l ruby --language=javascript

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Multiple parameters passed for '--language'. Only one argument can be passed for each flag." ]
}
