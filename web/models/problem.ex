defmodule ElixirExperience.Problem do
  defstruct number: 0, question: "", answer: ""

  @problems_directory "problems"

  def load_all do
    File.ls!(@problems_directory)
    |> Enum.sort
    |> Enum.map fn dir -> load_problem(dir) end
  end

  defp load_problem(directory) do
    [{directory, [problem: config]}] = Path.join([@problems_directory, directory, "config.exs"]) |> Mix.Config.read!
    config
  end
end
