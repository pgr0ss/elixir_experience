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

    EEx.eval_file(@test_template, assigns: [code: code, tests: problem.tests, before_test: before_test, after_test: after_test])
      |> evaluate(this, timeout)
      |> parse_output(before_test,after_test)
  end

  defp evaluate(code, this, timeout) do
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

  defp parse_output({output, 0}, before_test, after_test) do
    %{"output" => parsed_output} = Regex.named_captures(~r/.*#{before_test}(?<output>.*)#{after_test}/, output)

    results = String.split(parsed_output, ~r/\\n\ *\\n/)
      |> Enum.map(fn line -> Regex.named_captures(~r/(?<expected>.+?)@@@(?<actual>.+?)@@@(?<test>.*\z)/m, line) end)
      |> Enum.reject(fn result -> result == nil end)
      |> Enum.map(fn captures -> parse_captures(captures) end)

    {successes, failures} = Enum.partition(results, fn %{passed: passed} -> passed end)

    if Enum.count(failures) == 0 do
      {"", 0}
    else
      output = "Passed:\n#{Enum.map(successes, &format_test/1) |> Enum.join("\n")}\n\nFailed:\n#{Enum.map(failures, &format_test/1) |> Enum.join("\n")}"
      {output, 1}
    end
  end

  defp parse_output({output, 1}, _, _) do
    {Regex.replace(~r/(nofile:\d+: )|(#{@test_name}\.)|(\n.*)/, output, ""), 1}
  end

  defp parse_output(result, _, _), do: result

  defp parse_captures(captures) do
    expected = captures["expected"] |> String.strip |> String.replace("\\", "")
    actual = captures["actual"] |> String.strip |> String.replace("\\", "")
    %{expected: expected, actual: actual, test: captures["test"], passed: expected == actual}
  end

  defp format_test(%{expected: expected, actual: actual, test: test}) do
    "  assert #{test} == #{expected} #=> #{actual}"
  end
end
