defmodule ElixirExperience.Docker do
  def run(code) do
    this = self
    spawn(fn -> send(this, System.cmd("docker", ["run", "--name=\"#{container_name}\"", "trenpixster/elixir", "elixir", "-e", code], stderr_to_stdout: true)) end)
    {output, exit_code} = receive do
      any -> any
    after(2000) ->
      System.cmd("docker", ["kill", container_name])
      System.cmd("docker", ["rm", container_name])

      {"", 124}
    end

    {String.strip(output), exit_code}
  end

  defp container_name do
    :random.seed(:os.timestamp)
    Enum.map(1..20, fn _ -> (:random.uniform * 25 + 65) |> round end) |> to_string
  end
end
