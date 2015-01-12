defmodule ElixirExperience.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://localhost/elixir_experience"
  end

  def priv do
    app_dir(:elixir_experience, "priv/repo")
  end
end
