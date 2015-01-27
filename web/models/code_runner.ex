defmodule ElixirExperience.CodeRunner do
  @test_template "code_templates/test.txt.eex"
  @test_name "ElixirExperienceTest"

  alias ElixirExperience.Docker
  alias ElixirExperience.RandomStringGenerator

  def run(code, problem) do
    before_test = ">>>" <> RandomStringGenerator.generate <> "<<<"
    after_test = ">>>" <> RandomStringGenerator.generate <> "<<<"

    code = EEx.eval_file(@test_template,
      assigns: [
        code: code,
        tests: problem.tests,
        before_test: before_test,
        after_test: after_test
      ])

    {output, exit_code} = Docker.run(code)
    parse_output({output, exit_code}, before_test, after_test)
  end

  def parse_output({output, 0}, before_test, after_test) do
    %{"output" => parsed_output} = Regex.named_captures(~r/.*#{before_test}(?<output>.*)#{after_test}/, output)

    results = String.split(parsed_output, ~r/\\n\ *\\n/)
      |> Enum.map(fn line -> Regex.named_captures(~r/(?<expected>.+?)@@@(?<actual>.+?)@@@(?<test>.*\z)/m, line) end)
      |> Enum.reject(fn result -> result == nil end)
      |> Enum.map(fn captures -> parse_captures(captures) end)

    {successes, failures} = Enum.partition(results, fn %{passed: passed} -> passed end)

    if Enum.count(failures) == 0 do
      {:passed, ""}
    else
      output = "Passed:\n#{Enum.map(successes, &format_test/1) |> Enum.join("\n")}\n\nFailed:\n#{Enum.map(failures, &format_test/1) |> Enum.join("\n")}"
      {:failed, output}
    end
  end

  def parse_output({output, 1}, _, _) do
    {:failed, Regex.replace(~r/(nofile:\d+: )|(#{@test_name}\.)|(\n.*)/, output, "")}
  end

  def parse_output({output, 124}, _, _) do
    {:timedout, output}
  end

  def parse_output({output, exit_code}, _, _) do
    {:failed, output}
  end

  defp parse_captures(captures) do
    expected = captures["expected"] |> String.strip |> String.replace("\\", "")
    actual = captures["actual"] |> String.strip |> String.replace("\\", "")
    %{expected: expected, actual: actual, test: captures["test"], passed: expected == actual}
  end

  defp format_test(%{expected: expected, actual: actual, test: test}) do
    "  assert #{test} == #{expected} #=> #{actual}"
  end
end
