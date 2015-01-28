defmodule ElixirExperience.UserTest do
  use ExSpec, async: true
  import ElixirExperience.TransactionTestHelper, only: [with_transaction: 1]

  alias ElixirExperience.Problem
  alias ElixirExperience.User

  describe "insert_unless_exists" do
    it "inserts a record" do
      with_transaction do
        user = %User{github_id: 10, login: "me"}
        User.insert_unless_exists(user)
        found_user = User.find_by_github_id(10)
        assert found_user.login == "me"
      end
    end

    it "does not insert a record if it exists" do
      with_transaction do
        first = %User{github_id: 10, login: "first"} |> ElixirExperience.Repo.insert
        second = %User{github_id: 10, login: "second"}

        User.insert_unless_exists(second)

        assert User.find_by_github_id(10) == first
      end
    end
  end

  describe "find_by_id" do
    it "finds a user by id" do
      with_transaction do
        user = %User{login: "me"} |> ElixirExperience.Repo.insert
        assert User.find_by_id(user.id).login == "me"
      end
    end
  end

  describe "create_solution" do
    it "creates UserSolutions" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert

        User.create_solution(user, %Problem{number: 1}, "foo")
        User.create_solution(user, %Problem{number: 2}, "bar")

        found_user = User.find_by_id(user.id)

        solution_1 = found_user.user_solutions |> Enum.at(0)
        solution_2 = found_user.user_solutions |> Enum.at(1)

        assert solution_1.problem_number == 1
        assert solution_1.code == "foo"

        assert solution_2.problem_number == 2
        assert solution_2.code == "bar"
      end
    end

    it "strips the code" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        User.create_solution(user, %Problem{number: 1}, "   foo\t\n")
        solution = User.find_by_id(user.id).user_solutions |> Enum.at(0)
        assert solution.code == "foo"
      end
    end
  end

  describe "solved?" do
    it "returns false when the user is nil" do
      assert User.solved?(nil, %Problem{}) == false
    end

    it "returns false when there are no user_solutions" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        assert User.solved?(user, %Problem{}) == false
      end
    end

    it "returns false when there are no user_solutions for the given problem" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        User.create_solution(user, %Problem{number: 1}, "")
        assert User.solved?(user, %Problem{number: 2}) == false
      end
    end

    it "returns true when there is a user_solutions for the given problem" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        User.create_solution(user, %Problem{number: 1}, "")
        assert User.solved?(user, %Problem{number: 1}) == true
      end
    end
  end

  describe "timestamps" do
    it "records timestamps" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert
        assert user.inserted_at != nil
        assert user.updated_at != nil
      end
    end
  end
end
