defmodule ElixirExperience.Docker do
  def run(code) do
    {output, exit_code} = System.cmd("docker", ["run", "--net=none", "--rm", "trenpixster/elixir", "elixir", "-e", code], stderr_to_stdout: true)
    {String.strip(output), exit_code}
  end
end
