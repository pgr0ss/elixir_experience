ExUnit.start

defmodule ElixirExperience.TransactionTestHelper do
  defmacro with_transaction(body) do
    quote do
      ElixirExperience.Repo.transaction fn ->
        unquote(body[:do])
        ElixirExperience.Repo.rollback(:test_complete)
      end
    end
  end
end
