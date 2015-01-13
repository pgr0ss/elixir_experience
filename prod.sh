#!/usr/bin/env bash

# Stop if any commands fail
set -e

source ./.env

MIX_ENV=prod mix deps.get
MIX_ENV=prod mix compile.protocols
MIX_ENV=prod mix ecto.migrate ElixirExperience.Repo
MIX_ENV=prod PORT=4000 elixir -pa _build/prod/consolidated -S mix phoenix.server
