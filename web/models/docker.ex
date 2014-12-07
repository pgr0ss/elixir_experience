defmodule ElixirExperience.Docker do
  def run(code) do
    this = self
    container_name = ElixirExperience.RandomStringGenerator.generate

    spawn(fn -> send(this, {:shell_result, System.cmd("docker", ["run", "--net=none", "--rm", "--name=\"#{container_name}\"", "trenpixster/elixir", "elixir", "-e", code], stderr_to_stdout: true)}) end)

    {output, exit_code} = receive do
      {:shell_result, result} -> result
    after(2000) ->
      System.cmd("docker", ["kill", container_name])

      {"Your code took longer than 2 seconds to run", 124}
    end

    {String.strip(output), exit_code}
  end
end
