defmodule ElixirExperience.ProblemControllerTest do
  use ExSpec, async: true
  use Plug.Test

  import ElixirExperience.TransactionTestHelper, only: [with_transaction: 1]

  alias ElixirExperience.User

  describe "show" do
    it "shows a problem" do
      conn = conn(:get, "/problems/1") |> ElixirExperience.Endpoint.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Write a function called add that takes two numbers and returns their sum")
      assert String.contains?(conn.resp_body, "<pre><code class=\"elixir\">add(1, 2) #=&gt; 3</code></pre>") == true
    end
  end

  describe "update" do
    it "runs code" do
      conn = conn(:put, "/problems/2", %{"code" => """
        def num_to_list(n) do
          Enum.join(1..n, \",\")
        end
      """}) |> ElixirExperience.Endpoint.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Correct!")
      refute String.contains?(conn.resp_body, "What went wrong:")
    end

    it "includes a reason for non-zero exit code" do
      conn = conn(:put, "/problems/2", %{"code" => """
        def num_to_list do
        end
      """}) |> ElixirExperience.Endpoint.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Not quite!")
      assert String.contains?(conn.resp_body, "What went wrong:")
      assert String.contains?(conn.resp_body, "<code class=\"elixir\">** (UndefinedFunctionError) undefined function: num_to_list/1</code>")
    end

    it "creates a solution on success" do
      with_transaction do
        user = %User{} |> ElixirExperience.Repo.insert

        conn = conn(:put, "/problems/1", %{"code" => """
          def add(x,y), do: x + y
        """})
        |> assign(:current_user, user)
        |> ElixirExperience.Endpoint.call([])

        assert conn.status == 200
        assert String.contains?(conn.resp_body, "Correct!")

        found_user = User.find_by_id(user.id)
        solution = found_user.user_solutions |> Enum.at(0)

        assert solution.problem_number == 1
        assert solution.code == "def add(x,y), do: x + y"
      end
    end
  end
end
