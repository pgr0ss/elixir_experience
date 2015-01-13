defmodule ElixirExperience.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url config[:database_url]
  end

  def config do
    Application.get_env(:elixir_experience, :database)
  end

  def priv do
    app_dir(:elixir_experience, "priv/repo")
  end
end
