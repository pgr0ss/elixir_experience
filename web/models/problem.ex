defmodule ElixirExperience.Problem do
  defstruct number: 0, question: "", solution: "", tests: []

  @problems_path "config/problems.exs"

  def load_all do
    [problems: [problems: problems]] = Mix.Config.read!(@problems_path)
    problems
  end
end
