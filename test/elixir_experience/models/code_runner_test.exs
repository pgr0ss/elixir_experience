defmodule ElixirExperience.CodeRunnerTest do
  use ExSpec, async: true

  alias ElixirExperience.CodeRunner

  describe "run" do
    it "fails code with invalid syntax" do
      code = """
        def foo(a) do
          a
        end
      """
      problem =  %{
        answer: "42",
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }

      {output, exit_code} = CodeRunner.run(code, problem)
      assert exit_code == 1
      assert String.contains?(output, "cannot invoke def/2 outside module")
    end

    it "fails code that doesn't pass test" do
      code = """
        defmodule Fibonacci do
          def fib(_) do
            [1,1]
          end
        end
        Fibonacci.fib(20) |> inspect |> IO.puts
      """
      problem =  %{
        answer: "[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765]",
        question: """
        Write a Fibonacci module with a fib function that takes a number and return a list of size n of fibonacci numbers, e.g:

        defmodule Fibonacci do
          def fib(num) do
            #your code goes here
          end
        end
        """,
        number: 003,
        runner: """
          Fibonacci.fib(20) |> inspect |> IO.puts
        """,
        tests: [
          """
            assert Fibonacci.fib(2) == [1, 1]
          """,
          """
            assert Fibonacci.fib(5) == [1, 1, 2, 3, 5]
          """
        ]
      }

      {output, exit_code} = CodeRunner.run(code, problem)
      assert exit_code == 1
      assert String.contains?(output, "assert Fibonacci.fib(5) == [1, 1, 2, 3, 5]")
    end

    Enum.each ElixirExperience.Problem.load_all, fn(problem) ->
      it "problem number #{problem[:number]}" do
        problem = unquote(Macro.escape(problem))
        {output, exit_code} = ElixirExperience.CodeRunner.run(problem[:solution], problem)
        assert exit_code == 0
        assert output == problem[:answer]
      end
    end
  end
end
