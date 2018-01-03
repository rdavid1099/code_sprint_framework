#!/usr/bin/env bats

load test_helper

setup()
{
  export ENV='test'
}

@test "does something" {
  run bash $SPRINTR
}
