#!/usr/bin/env bash

# Stop if any commands fail
set -e

docker rm -f $(docker ps -a -q)
