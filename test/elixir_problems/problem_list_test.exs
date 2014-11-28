defmodule ElixirProblems.ProblemListTest do
  use ExUnit.Case, async: true

  test "number_of_problems" do
    assert ElixirProblems.ProblemList.number_of_problems == 2
  end

  test "get_problem" do
    assert ElixirProblems.ProblemList.get_problem(1).answer == "42"
  end
end
