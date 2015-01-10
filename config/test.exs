use Mix.Config

config :elixir_experience, ElixirExperience.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :logger, :console,
  level: :error
