defmodule ElixirExperience.Repo do
  use Ecto.Repo,
    otp_app: :elixir_experience,
    adapter: Ecto.Adapters.Postgres
end
