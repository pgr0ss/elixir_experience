defmodule ElixirExperience.Docker do
  @image_name "trenpixster/elixir"

  def pull_image do
    unless image_exists? do
      require Logger
      Logger.info "Pulling Docker image #{@image_name}"
      {_output, 0} = System.cmd("docker", ["pull", @image_name], stderr_to_stdout: true)
    end
  end

  defp image_exists? do
    {output, 0} = System.cmd("docker", ["images"], stderr_to_stdout: true)
    String.contains?(output, @image_name)

    require Logger
    Logger.info "Pulling Docker image #{@image_name}"
    {_output, 0} = System.cmd("docker", ["pull", @image_name], stderr_to_stdout: true)
  end

  def run(code, timeout \\ 5000) do
    this = self
    container_name = ElixirExperience.RandomStringGenerator.generate

    spawn(fn -> send(this, {:shell_result, System.cmd("docker", ["run", "--net=none", "--rm", "--name=\"#{container_name}\"", @image_name, "elixir", "-e", code], stderr_to_stdout: true)}) end)

    {output, exit_code} = receive do
      {:shell_result, result} -> result
    after(timeout) ->
      System.cmd("docker", ["kill", container_name], stderr_to_stdout: true)

      {"Your code took longer than 2 seconds to run", 124}
    end

    {String.strip(output), exit_code}
  end
end
