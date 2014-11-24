defmodule ElixirProblems.Docker do
  def run(code) do
    {output, exit_code} = System.cmd("docker", ["run", "trenpixster/elixir", "elixir", "-e", code])
    {String.strip(output), exit_code}
  end
end
