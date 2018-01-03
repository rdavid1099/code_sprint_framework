#!/usr/bin/env bats

load test_helper

setup()
{
  export ENV='test'
  export PARENT_PATH=$PWD
}

@test "it does something" {
  run bash $NEW
}
