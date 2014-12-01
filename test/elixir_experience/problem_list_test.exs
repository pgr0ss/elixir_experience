defmodule ElixirExperience.ProblemListTest do
  use ExUnit.Case, async: true

  test "number_of_problems" do
    assert ElixirExperience.ProblemList.number_of_problems == 2
  end

  test "get_problem" do
    assert ElixirExperience.ProblemList.get_problem(1).answer == "42"
  end
end
