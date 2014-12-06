defmodule ElixirExperience.ProblemControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "index" do
    conn = conn(:get, "/problems") |> ElixirExperience.Router.call([])

    assert conn.status == 200

    assert String.contains?(conn.resp_body, "Problem 3") == true
  end

  test "show" do
    conn = conn(:get, "/problems/1") |> ElixirExperience.Router.call([])

    assert conn.status == 200

    assert String.contains?(conn.resp_body, "prints the number 42") == true
  end

  test "update" do
    conn = conn(:put, "/problems/1", %{"code" => "IO.puts 10"}) |> ElixirExperience.Router.call([])

    assert conn.status == 200

    assert String.contains?(conn.resp_body, "<pre>10</pre>") == true
  end

  test "update includes a reason for non-zero exit code" do
    conn = conn(:put, "/problems/1", %{"code" => ":timer.sleep(3000)"}) |> ElixirExperience.Router.call([])

    assert conn.status == 200

    assert String.contains?(conn.resp_body, "What went wrong:") == true
    assert String.contains?(conn.resp_body, "<pre>Your code took longer than 2 seconds to run</pre>") == true
  end
end
