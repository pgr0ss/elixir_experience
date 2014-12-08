defmodule ElixirExperience.CodeRunner do
  @test_template "code_templates/test.txt.eex"
  @code_template "code_templates/code.txt.eex"

  def run(code, problem) do
    case run_test(code, problem[:tests]) do
      {output, 0} -> run_code(code, problem)
      result -> result
    end
  end

  def run_code(code, problem) do
    ElixirExperience.Docker.run(code)
  end

  def run_test(code, tests) do
    run_test(code, tests, {"", 0})
  end

  def run_test(code, [test|rest], result) do
    result = EEx.eval_file(@test_template, assigns: [code: code, test: test]) |> ElixirExperience.Docker.run
    case result do
      {output, 0} -> run_test(code, rest, result)
      {_, exit_code} -> {test, exit_code}
    end
  end

  def run_test(code, [], result) do
    result
  end
end
