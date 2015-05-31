defmodule ElixirExperience.ProblemView do
  use ElixirExperience.View

  def show_next_button?(:passed, problem) do
    problem.number < length(ElixirExperience.ProblemList.problems)
  end

  def show_next_button?(_, _) do
    false
  end
end
