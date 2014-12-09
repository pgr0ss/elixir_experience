defmodule ElixirExperience.CodeRunner do
  @test_template "code_templates/test.txt.eex"
  @code_template "code_templates/code.txt.eex"

  def run(code, problem) do
    test_results = validate_code(code) |> run_test(code, problem[:tests])
    case test_results do
      {_, 0} -> run_code(code, problem)
      result -> result
    end
  end

  defp validate_code(code) do
    ElixirExperience.Docker.run(code)
  end

  defp run_code(code, problem) do
    EEx.eval_file(@code_template, assigns: [code: code, runner: problem[:runner]]) |> ElixirExperience.Docker.run
  end

  defp run_test({_, 0}, code, [test|rest]) do
    result = EEx.eval_file(@test_template, assigns: [code: code, test: test]) |> ElixirExperience.Docker.run
    case result do
      {output, 0} -> run_test(result, code, rest)
      {_, exit_code} -> {test, exit_code}
    end
  end

  defp run_test(result, code, []) do
    result
  end
end
