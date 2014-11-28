defmodule ElixirProblems.ProblemTest do
  use ExUnit.Case, async: true

  test "problem struct" do
    problem = %ElixirProblems.Problem{question: "some question", answer: "some answer"}
    assert problem.question == "some question"
    assert problem.answer == "some answer"
  end

  test "load_all" do
    problems = ElixirProblems.Problem.load_all
    assert Enum.count(problems) == 2

    first_problem = Enum.at(problems, 0)
    assert String.contains?(first_problem.question, "prints the number 42") == true
    assert first_problem.answer == "42"
  end
end
