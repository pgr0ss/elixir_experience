use Mix.Config
alias ElixirExperience.Problem

config :"002",
  problem: %Problem{
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
  }
