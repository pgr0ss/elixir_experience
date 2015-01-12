defmodule ElixirExperience.UserTest do
  use ExSpec, async: true
  import ElixirExperience.TransactionTestHelper, only: [with_transaction: 1]

  alias ElixirExperience.User

  describe "insert_unless_exists" do
    it "inserts a record" do
      with_transaction do
        user = %User{github_id: 10}
        User.insert_unless_exists(user)
        found_user = User.find_by_github_id(10)
        assert user == %User{found_user | id: nil}
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
        user = %User{} |> ElixirExperience.Repo.insert
        assert User.find_by_id(user.id) == user
      end
    end
  end
end
