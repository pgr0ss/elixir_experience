defmodule ElixirExperience.ProblemListTest do
  use ExSpec, async: true

  alias ElixirExperience.ProblemList

  describe "number_of_problems" do
    it "returns the number of problmes" do
      assert ProblemList.number_of_problems > 2
    end
  end

  describe "get_problem" do
    it "returns the specific problem" do
      assert ProblemList.get_problem(1).answer == "42"
    end
  end
end
