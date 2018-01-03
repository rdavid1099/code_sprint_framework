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

@test "it assigns time value when --time flag is passed" {
  run bash $NEW --time=45

  [ "$status" -eq "0" ]
  [ "${lines[2]}" = "Sprint foundation built with a 45 minute time limit and auto-commits every 10 minutes" ]
}

@test "it assigns origin value when -t flag is passed" {
  run bash $NEW -t 75

  [ "$status" -eq "0" ]
  [ "${lines[2]}" = "Sprint foundation built with a 75 minute time limit and auto-commits every 10 minutes" ]
}

@test "it throws error if number not passed" {
  run bash $NEW -t foobar

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: 'TIME' must be an integer between 1 and 255" ]
}

@test "it throws error if number less than 1 is passed" {
  run bash $NEW -t 0

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: 'TIME' must be an integer between 1 and 255" ]
}

@test "it throws error if number more than 255 is passed" {
  run bash $NEW -t 1234

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: 'TIME' must be an integer between 1 and 255" ]
}

@test "it throws error when multiple times are passed" {
  run bash $NEW -t 10 --time=15

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Multiple parameters passed for 'TIME'. Only one argument can be passed for each flag." ]
}

@test "it assigns frequency value when --frequency flag is passed" {
  run bash $NEW --frequency=15

  [ "$status" -eq "0" ]
  [ "${lines[2]}" = "Sprint foundation built with a 60 minute time limit and auto-commits every 15 minutes" ]
}

@test "it assigns origin value when -f flag is passed" {
  run bash $NEW -f 5

  [ "$status" -eq "0" ]
  [ "${lines[2]}" = "Sprint foundation built with a 60 minute time limit and auto-commits every 5 minutes" ]
}

@test "it throws error if frequency is greater than time" {
  run bash $NEW -f 15 --time=10

  [ "$status" -eq "1" ]
  [ "${lines[0]}" = "ERROR: Commit frequency must be less than the time of the sprint" ]
}

@test "it creates a foundation with all params passed" {
  run bash $NEW -fn test_sprint -l ruby -o remote@gittest.com:foo/bar.git -t 75 -f 15

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Building Ruby sprint named test_sprint" ]
  [ "${lines[1]}" = "Initializing git repository with origin 'remote@gittest.com:foo/bar.git'" ]
  [ "${lines[2]}" = "Sprint foundation built with a 75 minute time limit and auto-commits every 15 minutes" ]
  [ "${lines[3]}" = "Run 'sprintr start test_sprint' to begin the sprint" ]
}
