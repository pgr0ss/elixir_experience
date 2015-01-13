use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :elixir_experience, ElixirExperience.Endpoint,
  url: [host: "elixirexperience.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "VFeTGrUj5L5TxuLlyFI/ldw+JhyPLdlRG0TOR33mzyBSKNdw8pCK7fKLNdcr0pad"

config :logger,
  level: :info

config :elixir_experience, :github_oauth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET"),
  redirect_url: "http://elixirexperience.com/github_oauth"

config :elixir_experience, :database,
  database_url: "ecto://elixir_experience@#{System.get_env("POSTGRES_PORT_5432_TCP_ADDR")}:#{System.get_env("POSTGRES_PORT_5432_TCP_PORT")}/elixir_experience"
