defmodule ElixirExperience.ProblemTest do
  use ExSpec, async: true

  alias ElixirExperience.Problem

  describe "struct" do
    it "has fields" do
      problem = %Problem{number: 5, question: "some question"}
      assert problem.number == 5
      assert problem.question == "some question"
    end
  end

  describe "load_all" do
    it "loads the problems from disk" do
      problems = Problem.load_all
      assert Enum.count(problems) > 2

      first_problem = Enum.at(problems, 0)
      assert first_problem.number == 1
      assert first_problem.question == "Write a function called add that takes two numbers and returns their sum"
    end
  end
end
