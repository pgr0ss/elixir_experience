defmodule Mix.Tasks.Docker do
  defmodule Pull do
    use Mix.Task

    @shortdoc "Pulls the docker image"
    @moduledoc "Pulls the docker image"

    def run(_args) do
      ElixirExperience.Docker.pull_image
    end
  end
end
