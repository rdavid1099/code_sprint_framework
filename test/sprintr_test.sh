#!/usr/bin/env bats

load test_helper

setup()
{
  export ENV='test'
}

@test "it displays manual when no params are passed" {
  run bash $SPRINTR

  [ "$status" -eq "0" ]
  [ "${lines[0]}" = "Welcome to Sprintr: Code sprint launcher client" ]
}
