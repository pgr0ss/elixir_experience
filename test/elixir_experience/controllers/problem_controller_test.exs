defmodule ElixirExperience.ProblemControllerTest do
  use ExSpec, async: true
  use Plug.Test

  describe "index" do
    it "shows a list of problems" do
      conn = conn(:get, "/problems") |> ElixirExperience.Router.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Problem 3") == true
    end
  end

  describe "show" do
    it "shows a problem" do
      conn = conn(:get, "/problems/1") |> ElixirExperience.Router.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Write a function called add that takes two numbers and returns their sum")
    end
  end

  describe "update" do
    it "runs code" do
      conn = conn(:put, "/problems/2", %{"code" => """
        def num2list(n) do
          Enum.join(1..n, \",\")
        end
      """}) |> ElixirExperience.Router.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Correct!")
      refute String.contains?(conn.resp_body, "What went wrong:")
    end

    it "includes a reason for non-zero exit code" do
      conn = conn(:put, "/problems/2", %{"code" => """
        def num2list do
        end
      """}) |> ElixirExperience.Router.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Not quite!")
      assert String.contains?(conn.resp_body, "What went wrong:")
      assert String.contains?(conn.resp_body, "<pre>** (UndefinedFunctionError) undefined function: num2list/1</pre>")
    end
  end
end
