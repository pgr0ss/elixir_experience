defmodule ElixirExperience.PageControllerTest do
  use ExSpec, async: true
  use Plug.Test

  describe "index" do
    it "shows a list of problems" do
      conn = conn(:get, "/") |> ElixirExperience.Endpoint.call([])

      assert conn.status == 200
      assert String.contains?(conn.resp_body, "<a href=\"/problems/3\">03</a>") == true
    end
  end
end
