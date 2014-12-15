use Mix.Config
alias ElixirExperience.Problem

config :"003",
  problem: %Problem{
    number: 003,
    question: """
    Write a Fibonacci module with a fib function that takes a number and return a list of size n of fibonacci numbers, e.g:

    defmodule Fibonacci do
      def fib(num) do
        #your code goes here
      end
    end
    """,
    solution: """
      defmodule Fibonacci do
        def fib(num) do
          Stream.unfold({1, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(num)
        end
      end
    """,
    tests: [
      """
        Fibonacci.fib(2) == [1, 1]
      """,
      """
        Fibonacci.fib(5) == [1, 1, 2, 3, 5]
      """
    ]
  }
