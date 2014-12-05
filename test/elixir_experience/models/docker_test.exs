defmodule ElixirExperience.DockerTest do
  use ExUnit.Case, async: true

  test "run a simple elixir command" do
    {output, exit_code} = ElixirExperience.Docker.run("IO.puts(42)")
    assert exit_code == 0
    assert output == "42"
  end

  test "run a bad command" do
    {output, exit_code} = ElixirExperience.Docker.run("garbage")
    assert exit_code == 1
    assert String.contains?(output, "undefined function garbage/0")
  end

  test "run a multiline elixir command" do
    code = """
      x = "hello"
      y = "world"
      z = x <> " " <> y
      IO.puts(z)
    """
    {output, exit_code} = ElixirExperience.Docker.run(code)
    assert exit_code == 0
    assert output == "hello world"
  end

  test "no access to network" do
    code = """
    :inets.start
    {:ok, result} = :httpc.request(:get, {'http://google.com', []}, [], [])
    IO.puts elem(result, 2)
    """

    {output, exit_code} = ElixirExperience.Docker.run(code)
    assert exit_code == 1
    assert String.contains?(output, ":failed_connect")
  end
end
