defmodule ElixirExperience.DockerTest do
  use ExSpec, async: true

  alias ElixirExperience.Docker
  alias ElixirExperience.Problem

  describe "run" do
    it "runs a bad code and captures output" do
      code = "garbage"
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }

      {output, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert output == "** (CompileError) undefined function garbage/0"
    end

    it "runs code without a function and does not include ElixirExperienceTest in its output" do
      code = """
        defmodule Experience do
          def num2list do
          end
        end
      """
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: [
          """
          Experience.num2list(10) == \"1,2,3,4,5,6,7,8,9,10\"
          """
        ]
      }

      {output, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert output == "** (UndefinedFunctionError) undefined function: Experience.num2list/1"
    end

    it "does not fail when there is an unused variable" do
      code = """
        defmodule Experience do
          def num2list(n) do
          end
        end
      """
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: [
          """
          Experience.num2list(10) == \"1,2,3,4,5,6,7,8,9,10\"
          """
        ]
      }

      {output, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert output == "Failures:\n\nassert Experience.num2list(10) == \"1,2,3,4,5,6,7,8,9,10\""
    end

    it "fails code with invalid syntax" do
      code = """
        def foo(a)
          a
        end
      """
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }

      {output, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert output == "** (SyntaxError) unexpected token: end"
    end

    it "does not block longer than timeout" do
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }

      {output, exit_code} = Docker.run(":timer.sleep(1000)", problem, 10)
      assert exit_code == 124
      assert output == "Your code took longer than 0.01 seconds to run"
    end

    it "has no access to the network" do
      code = """
      :inets.start
      {:ok, result} = :httpc.request(:get, {'http://google.com', []}, [], [])
      IO.puts elem(result, 2)
      """
      problem =  %Problem{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }

      {output, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert String.contains?(output, ":failed_connect")
    end

    it "fails code that doesn't pass test" do
      code = """
        defmodule Fibonacci do
          def fib(_) do
            [1,1]
          end
        end
      """
      problem =  %Problem{
        question: """
        Write a Fibonacci module with a fib function that takes a number and return a list of size n of fibonacci numbers, e.g:

        defmodule Fibonacci do
          def fib(num) do
            #your code goes here
          end
        end
        """,
        number: 003,
        tests: [
          """
            Fibonacci.fib(2) == [1, 1]
          """,
          """
            Fibonacci.fib(3) == [1, 1, 2]
          """,
          """
            Fibonacci.fib(5) == [1, 1, 2, 3, 5]
          """
        ]
      }

      {reason, exit_code} = Docker.run(code, problem)
      assert exit_code == 1
      assert reason == "Failures:\n\nassert Fibonacci.fib(5) == [1, 1, 2, 3, 5]\nassert Fibonacci.fib(3) == [1, 1, 2]"
    end

    Enum.each ElixirExperience.Problem.load_all, fn(problem) ->
      it "problem number #{problem.number}" do
        problem = unquote(Macro.escape(problem))
        {output, exit_code} = ElixirExperience.Docker.run(problem.solution, problem)
        assert exit_code == 0
        assert output == ""
      end
    end
  end
end

defmodule ElixirExperience.DockerTestNotAsync do
  use ExSpec, async: false

  alias ElixirExperience.Docker

  describe "run" do
    it "cleans up temporary containers" do
      before_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count
      problem =  %{
        question: """
        Write an elixir program that prints the number 42 to stdout.
        """,
        number: 001,
        tests: []
      }
      {_, 0} = Docker.run("", problem)
      after_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count

      assert before_containers == after_containers
    end
  end
end
