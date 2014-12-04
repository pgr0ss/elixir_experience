#!/usr/bin/env bash

docker build -t elixir_experience .
docker run -d -p 4000:4000 --privileged -e VIRTUAL_HOST=elixirexperience.com,www.elixirexperience.com elixir_experience

docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy
