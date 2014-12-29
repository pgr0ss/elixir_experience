defmodule ElixirExperience.Docker do
  require Logger

  @image_name "trenpixster/elixir"
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
    String.contains?(output, @image_name)
  end

  def run(code, problem, timeout \\ 5000) do
    this = self
    before_test = ">>>" <> ElixirExperience.RandomStringGenerator.generate <> "<<<"
    after_test = ">>>" <> ElixirExperience.RandomStringGenerator.generate <> "<<<"

    EEx.eval_file(@test_template,
      assigns: [code: code, tests: problem.tests, before_test: before_test, after_test: after_test])
      |> evaluate(this, timeout) |> parse_output(before_test,after_test)
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

  defp parse_output({output, 0}, before_test, after_test) do
    %{"output" => parsed_output} = Regex.named_captures(~r/.*#{before_test}(?<output>.*)#{after_test}/, output)

    if parsed_output == "" do
      failures = []
    else
      failures = capture_failures(parsed_output)
    end

    case failures do
      [] -> {"", 0}
      _ -> {"Failures:\n\n" <> (Enum.map(failures, fn %{"success" => success, "test" => failed} ->
        "assert " <> (failed |> Macro.unescape_string |> String.strip)
      end) |> Enum.join("\n")), 1}
    end
  end

  defp parse_output({output, 1}, _, _) do
    {Regex.replace(~r/(nofile:\d+: )|(#{@test_name}\.)|(\n.*)/, output, ""), 1}
  end

  defp parse_output(result, _, _), do: result

  defp capture_failures(parsed_output) do
    String.split(parsed_output, ~r/\\n\ *\\n/)
      |> Enum.map(fn string -> Regex.named_captures(~r/(?<success>\w+),(?<test>.*\z)/m, string) end)
      |> Enum.reject(fn(%{"success" => success, "test" => test}) -> String.contains?(success, "true")
        nil -> true
      end)
  end
end
