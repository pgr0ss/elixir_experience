defmodule Mix.Tasks.Db do
  defmodule Reset do
    use Mix.Task

    @shortdoc "Resets the database"
    @moduledoc "Resets the database"

    def run(_args) do
      Mix.Task.run("ecto.drop", ["ElixirExperience.Repo"])
      Mix.Task.run("ecto.create", ["ElixirExperience.Repo"])
      Mix.Task.run("ecto.migrate", ["ElixirExperience.Repo"])
    end
  end
end
