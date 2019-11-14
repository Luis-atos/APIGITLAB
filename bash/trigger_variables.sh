#!/bin/bash

# Uses trigger pipelien token

TOKEN=""
curl -X POST \
  -F token=$TOKEN \
  -F ref='master' \
  --form "variables[CUSTOM_FILE]='/<>'" \
  https://gitlab.test.tech/api/v4/projects/292/trigger/pipeline

