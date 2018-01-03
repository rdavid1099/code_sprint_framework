#!/bin/bash

invalid_command() {
  echo -e "ERROR: Command '${1}' not recognized. Enter 'sprintr --help' for a list of valid commands."
  echo -e "Terminating Process"
  exit 1
}
