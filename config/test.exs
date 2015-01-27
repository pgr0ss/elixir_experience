use Mix.Config

config :elixir_experience, ElixirExperience.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :logger, :console,
  level: :error

config :elixir_experience, :github_oauth,
  client_id: "8564df8d0cc88bff6796",
  client_secret: "61bba5af5544c1af5200c001aad91cd8827917b3",
  redirect_url: "http://localhost:4001/github_oauth"

config :elixir_experience, ElixirExperience.Repo,
  url: "ecto://localhost/elixir_experience"
