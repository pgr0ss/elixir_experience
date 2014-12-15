use Mix.Config
alias ElixirExperience.Problem

config :problems,
  problems: [
  %Problem{
    number: 001,
    question: "Write a function called add that takes two numbers and returns their sum",
    solution: """
    def add(x, y) do
      x + y
    end
    """,
    tests: [
      "add(1, 1) == 2",
      "add(3, 6) == 9",
      "add(4, 4) == 8",
    ]
  },
  %Problem{
    number: 002,
    question: """
    Write an elixir module Experience with a function num2list that takes a number and returns a string from 1 up to the number, e.g:

    Experience.num2list(10) #=> \"1,2,3,4,5,6,7,8,9,10\"
    """,
    solution: """
    defmodule Experience do
    def num2list(n) do
    Enum.join(1..n, \",\")
    end
    end
    """,
    tests: [
      """
      Experience.num2list(10) == \"1,2,3,4,5,6,7,8,9,10\"
      """,
      """
      Experience.num2list(1) == \"1\"
      """
    ]
  },
  %Problem{
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
]
