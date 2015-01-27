defmodule ElixirExperience.UserSolutionTest do
  use ExSpec, async: true
  import ElixirExperience.TransactionTestHelper, only: [with_transaction: 1]

  alias ElixirExperience.User
  alias ElixirExperience.UserSolution

  describe "timestamps" do
    it "records timestamps" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        user_solution = %UserSolution{user_id: user.id, problem_number: 1, code: ""} |> ElixirExperience.Repo.insert
        assert user_solution.inserted_at != nil
        assert user_solution.updated_at != nil
      end
    end
  end
end
