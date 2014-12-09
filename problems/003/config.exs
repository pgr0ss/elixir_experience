use Mix.Config

config :"003",
  problem: %{
    number: 003,
    answer: "[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765]",
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
