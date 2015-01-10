defmodule ElixirExperience.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_experience

  plug Plug.Static,
    at: "/", from: :elixir_experience

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elixir_experience_key",
    signing_salt: "ScD/SmcX",
    encryption_salt: "DP6nFwDP"

  plug :router, ElixirExperience.Router
end
