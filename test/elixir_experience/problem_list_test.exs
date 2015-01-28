defmodule ElixirExperience.ProblemListTest do
  use ExSpec, async: true

  alias ElixirExperience.ProblemList

  describe "number_of_problems" do
    it "returns the number of problmes" do
      assert ProblemList.number_of_problems > 2
    end
  end

  describe "problems" do
    it "returns all of the problems" do
      assert Enum.count(ProblemList.problems) > 2
      assert Enum.at(ProblemList.problems, 3).number == 4
    end
  end

  describe "get_problem" do
    it "returns the specific problem" do
      assert String.starts_with?(ProblemList.get_problem(1).question, "<p>Write a function called add that takes two numbers and returns their sum")
    end
  end
end
