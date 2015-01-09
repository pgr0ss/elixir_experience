defmodule ElixirExperience.Problem do
  defstruct number: 0, question: "", solution: "", tests: []

  @problems_path "config/problems.exs"

  def load_all do
    [problems: [problems: problems]] = Mix.Config.read!(@problems_path)
    Enum.map(problems, fn problem ->
      %ElixirExperience.Problem{problem | question: Earmark.to_html(problem.question)}
    end)
  end
end
