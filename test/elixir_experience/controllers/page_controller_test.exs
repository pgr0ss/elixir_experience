defmodule ElixirExperience.PageControllerTest do
  use ExSpec, async: true
  use Plug.Test

  alias ElixirExperience.User

  describe "index" do
    it "shows a list of problems" do
      conn = conn(:get, "/") |> ElixirExperience.Endpoint.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "Problem 3") == true
    end
  end
end
