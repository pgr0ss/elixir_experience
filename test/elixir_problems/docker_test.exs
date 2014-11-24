defmodule ElixirProblems.DockerTest do
  use ExUnit.Case

  test "run a simple elixir command" do
    {output, exit_code} = ElixirProblems.Docker.run("IO.puts(42)")
    assert exit_code == 0
    assert output == "42"
  end

  test "run a bad command" do
    {output, exit_code} = ElixirProblems.Docker.run("garbage")
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
    {output, exit_code} = ElixirProblems.Docker.run(code)
    assert exit_code == 0
    assert output == "hello world"
  end
end
