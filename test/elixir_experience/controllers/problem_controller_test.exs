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

      assert String.contains?(conn.resp_body, "prints the number 42") == true
    end
  end

  describe "update" do
    it "runs the code" do
      conn = conn(:put, "/problems/1", %{"code" => "IO.puts 10"}) |> ElixirExperience.Router.call([])

      assert conn.status == 200

      assert String.contains?(conn.resp_body, "<pre>10</pre>") == true
    end

    it "includes a reason for non-zero exit code" do
      conn = conn(:put, "/problems/1", %{"code" => ":timer.sleep(5000)"}) |> ElixirExperience.Router.call([])

      assert conn.status == 200

      assert String.contains?(conn.resp_body, "What went wrong:") == true
      assert String.contains?(conn.resp_body, "<pre>Your code took longer than 2 seconds to run</pre>") == true
    end
  end
end
