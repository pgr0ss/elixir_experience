defmodule ElixirExperience.Problem do
  defstruct number: 0, question: "", short_question: "", solution: "", tests: []

  @problems_path "config/problems.exs"

  def load_all do
    [problems: [problems: problems]] = Mix.Config.read!(@problems_path)
    Enum.map(problems, fn problem ->
      %ElixirExperience.Problem{problem |
        short_question: short_question(problem.question),
        question: Earmark.to_html(problem.question)}
    end)
  end

  def short_question(question) do
    short_question = question
    |> String.split("\n")
    |> List.first
    |> String.slice(0, 77)

    short_question <> "..."
  end
end
