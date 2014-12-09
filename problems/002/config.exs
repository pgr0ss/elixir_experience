use Mix.Config

config :"002",
  problem: %{
    number: 002,
    answer: "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100",
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
    runner: """
      IO.puts Experience.num2list(100)
    """,
    tests: [
      """
        assert Experience.num2list(10) == \"1,2,3,4,5,6,7,8,9,10\"
      """,
      """
        assert Experience.num2list(1) == \"1\"
      """
    ]
  }
