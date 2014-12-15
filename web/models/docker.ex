defmodule ElixirExperience.Docker do
  @image_name "trenpixster/elixir"
  @test_template "code_templates/test.txt.eex"
  @test_name "ElixirExperienceTest"

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
  end

  def run(code, problem, timeout \\ 5000) do
    this = self
    EEx.eval_file(@test_template, assigns: [code: code, tests: problem.tests]) |> evaluate(this, timeout) |> parse_output
  end

  defp evaluate(code, this, timeout) do
    container_name = ElixirExperience.RandomStringGenerator.generate
    spawn(fn -> send(this, {:shell_result, System.cmd("docker", ["run", "--net=none", "--rm", "--name=\"#{container_name}\"", "trenpixster/elixir", "elixir", "-e", code], stderr_to_stdout: true)}) end)

    {output, exit_code} = receive do
      {:shell_result, result} -> result
    after(timeout) ->
      System.cmd("docker", ["kill", container_name], stderr_to_stdout: true)

      {"Your code took longer than #{timeout/1000} seconds to run", 124}
    end

    {String.strip(output), exit_code}
  end

  defp parse_output({output, 0}) do
    output = Regex.replace(~r/^nofile.*\n/, output, "")
    {results, _} = Code.eval_string(output)

    failures = Enum.reject(results, fn result -> result[:success] end)
    case failures do
      [] -> {"", 0}
      _ -> {"Failures:\n\n" <> (Enum.map(failures, fn failed ->
        {failure, _} = Code.eval_string(failed[:body])
        "assert " <> failure
      end) |> Enum.join("\n")), 1}
    end
  end

  defp parse_output({output, 1}) do
    {Regex.replace(~r/(nofile:\d+: )|(#{@test_name}\.)|(\n.*)/, output, ""), 1}
  end

  defp parse_output(result), do: result
end
