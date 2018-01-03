#!/bin/bash

invalid_command() {
  echo "ERROR: Command '${1}' not recognized. Enter 'sprintr --help' for a list of valid commands."
  echo "Terminating Process"
  exit 1
}

repeating_params() {
  echo "ERROR: Multiple parameters passed for '${1}'. Only one argument can be passed for each flag."
  echo "Enter 'sprintr --help' for a list of valid commands."
  echo "Terminating Process"
  exit 1
}

unsupported_language() {
  echo "ERROR: Unsupported language '${1}' passed. Please pass a supported language."
  echo "For a list of all supported languages nter 'sprintr --help'."
  echo "Terminating Process"
  exit 1
}
