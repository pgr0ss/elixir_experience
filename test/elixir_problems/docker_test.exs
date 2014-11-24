defmodule ElixirProblems.DockerTest do
  use ExUnit.Case

  test "run a simple elixir command" do
    {output, exit_code} = ElixirProblems.Docker.run("IO.puts(42)")
    assert exit_code == 0
    assert output == "42"
  end
end
