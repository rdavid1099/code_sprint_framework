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
  [ "${lines[0]}" = "ERROR: Multiple parameters passed for 'LANGUAGE'. Only one argument can be passed for each flag." ]
}

@test "it assigns filename value when --filename flag is passed" {
  run bash $NEW --filename=test_sprint

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building JavaScript sprint named test_sprint" ]
}

@test "it assigns filename value when -fn flag is passed" {
  run bash $NEW -fn test_sprint

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building JavaScript sprint named test_sprint" ]
}

@test "it throws error when multiple filenames are passed" {
  run bash $NEW -fn foo --filename=bar

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Multiple parameters passed for 'FILENAME'. Only one argument can be passed for each flag." ]
}

@test "it assigns origin value when --origin flag is passed" {
  run bash $NEW --origin=remote@gittest.com:foo/bar.git

  [ "$status" -eq "0" ]
  [ "${lines[1]}" = "Initializing git repository with origin 'remote@gittest.com:foo/bar.git'" ]
}

@test "it assigns origin value when -o flag is passed" {
  run bash $NEW -o remote@gittest.com:foo/bar.git

  [ "$status" -eq "0" ]
  [ "${lines[1]}" = "Initializing git repository with origin 'remote@gittest.com:foo/bar.git'" ]
}

@test "it throws error when multiple origins are passed" {
  run bash $NEW -o foo --origin=bar

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Multiple parameters passed for 'ORIGIN'. Only one argument can be passed for each flag." ]
}
