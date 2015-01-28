#!/usr/bin/env bash

# Stop if any commands fail
set -e

docker run \
  --name postgres \
  -d \
  -v /var/lib/postgresql/data:/var/lib/postgresql/data \
  -e POSTGRES_USER=elixir_experience \
  postgres:9.4

docker build -t elixir_experience .

docker run \
  --name elixir \
  -d \
  --link postgres:postgres \
  -p 4000:4000 \
  --privileged \
  -v /var/lib/docker:/var/lib/docker \
  -e VIRTUAL_HOST=elixirexperience.com,www.elixirexperience.com \
  elixir_experience

docker run \
  --name nginx \
  -d \
  -p 80:80 \
  -v /var/run/docker.sock:/tmp/docker.sock \
  jwilder/nginx-proxy
