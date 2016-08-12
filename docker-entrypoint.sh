#!/bin/bash

# Set default timeout
if [ -z ${TIMEOUT+x} ]; then
  export TIMEOUT=120
fi

# Show environment for debugging purposes
env

# Render configuration template and start Kong if database is online
dockerize -delims "<%:%>" -template /etc/kong/kong.yml.template:/etc/kong/kong.yml -wait tcp://${DATABASE_HOST}:${DATABASE_PORT} -timeout ${TIMEOUT}s kong start