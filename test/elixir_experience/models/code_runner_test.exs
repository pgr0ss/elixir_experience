defmodule ElixirExperience.CodeRunnerTest do
  use ExSpec, async: true

  alias ElixirExperience.CodeRunner
  alias ElixirExperience.Problem

  describe "parse_output" do
    it "parses an error" do
      output = "** (CompileError) nofile:2: undefined function garbage/0\n    (stdlib) lists.erl:1352: :lists.mapfoldl/3"
      assert CodeRunner.parse_output({output, 1}, nil, nil) == {"** (CompileError) undefined function garbage/0", 1}
    end

    it "parses code without a function and does not include ElixirExperienceTest in the output" do
      output = """
** (UndefinedFunctionError) undefined function: ElixirExperienceTest.foo/1
  ElixirExperienceTest.foo(10)
  nofile:10: ElixirExperienceTest.run/0
  (stdlib) erl_eval.erl:657: :erl_eval.do_apply/6
  (stdlib) erl_eval.erl:865: :erl_eval.expr_list/6
  (stdlib) erl_eval.erl:407: :erl_eval.expr/5
  (elixir) lib/code.ex:140: Code.eval_string/3
"""
      assert CodeRunner.parse_output({output, 1}, nil, nil) == {"** (UndefinedFunctionError) undefined function: foo/1", 1}
    end

    it "parses success" do
      output = "\"  >>>QNKDIPMNTBVDSUTIDKZZ<<<\\n  \\n    1@@@1@@@foo(1)\\n  \\n    5@@@5@@@foo(5)\\n  \\n  >>>PEDTLWEDSHIFGFIUBTSC<<<\\n\""
      result = CodeRunner.parse_output({output, 0}, ">>>QNKDIPMNTBVDSUTIDKZZ<<<", ">>>PEDTLWEDSHIFGFIUBTSC<<<")
      assert result == {"", 0}
    end

    it "parses multiple test successes and failures" do
      output = "\"  >>>CXHJXJFSWSIWBHVKIOLC<<<\\n  \\n    [1, 1]@@@[1, 1]@@@fib(2)\\n  \\n    [1, 1, 2]@@@[1, 1]@@@fib(3)\\n  \\n    [1, 1, 2, 3, 5]@@@[1, 1]@@@fib(5)\\n  \\n  >>>MVVPSYXKDFEMLPBDBKZB<<<\\n\""
      result = CodeRunner.parse_output({output, 0}, ">>>CXHJXJFSWSIWBHVKIOLC<<<", ">>>MVVPSYXKDFEMLPBDBKZB<<<")
      assert result == {"Passed:\n  assert fib(2) == [1, 1] #=> [1, 1]\n\nFailed:\n  assert fib(3) == [1, 1, 2] #=> [1, 1]\n  assert fib(5) == [1, 1, 2, 3, 5] #=> [1, 1]", 1}
    end
  end

  describe "run" do
    it "runs bad code and captures output" do
      {output, exit_code} = CodeRunner.run("garbage", %Problem{})
      assert exit_code == 1
      assert output == "** (CompileError) undefined function garbage/0"
    end

    it "does not fail when there is an unused variable" do
      code = """
        def foo(n) do
        end
      """
      problem =  %Problem{
        tests: [
          ["foo(10)", "expected"]
        ]
      }

      {output, exit_code} = CodeRunner.run(code, problem)
      assert exit_code == 1
      assert output == "Passed:\n\n\nFailed:\n  assert foo(10) == \"expected\" #=> nil"
    end

    it "fails code with invalid syntax" do
      code = """
        def foo(a)
          a
        end
      """

      {output, exit_code} = CodeRunner.run(code, %Problem{})
      assert exit_code == 1
      assert output == "** (SyntaxError) unexpected token: end"
    end

    it "fails code that doesn't pass test" do
      code = """
        def fib(_) do
          [1,1]
        end
      """
      problem =  %Problem{
        tests: [
            ["fib(2)", [1, 1]],
            ["fib(3)", [1, 1, 2]],
            ["fib(5)", [1, 1, 2, 3, 5]],
        ]
      }

      {output, exit_code} = CodeRunner.run(code, problem)
      assert exit_code == 1
      assert output == "Passed:\n  assert fib(2) == [1, 1] #=> [1, 1]\n\nFailed:\n  assert fib(3) == [1, 1, 2] #=> [1, 1]\n  assert fib(5) == [1, 1, 2, 3, 5] #=> [1, 1]"
    end

    Enum.each Problem.load_all, fn(problem) ->
      it "problem number #{problem.number}" do
        problem = unquote(Macro.escape(problem))
        {output, exit_code} = CodeRunner.run(problem.solution, problem)
        assert exit_code == 0
        assert output == ""
      end
    end
  end
end
