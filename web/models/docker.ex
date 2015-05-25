defmodule ElixirExperience.Docker do
  require Logger

  @image_name "trenpixster/elixir:1.0.4"
  @test_template "code_templates/test.txt.eex"
  @test_name "ElixirExperienceTest"

  def pull_image do
    if image_exists? do
      Logger.info "Docker image is present: #{@image_name}"
    else
      Logger.info "Pulling Docker image: #{@image_name}"
      {_output, 0} = System.cmd("docker", ["pull", @image_name], stderr_to_stdout: true)
    end
  end

  defp image_exists? do
    {output, 0} = System.cmd("docker", ["images"], stderr_to_stdout: true)
    output
    |> String.replace(~r" +", ":")
    |> String.contains?(@image_name)
  end

  def run(code, timeout \\ 5000) do
    this = self
    container_name = ElixirExperience.RandomStringGenerator.generate
    spawn(fn -> send(this, {:shell_result, System.cmd("docker", ["run", "--net=none", "--rm", "--name=\"#{container_name}\"", @image_name, "elixir", "-e", code], stderr_to_stdout: true)}) end)

    {output, exit_code} = receive do
      {:shell_result, result} -> result
    after(timeout) ->
      System.cmd("docker", ["kill", container_name], stderr_to_stdout: true)

      {"Your code took longer than #{timeout/1000} seconds to run", 124}
    end

    {String.strip(output), exit_code}
  end
end
