use Mix.Config

config :"001",
  problem: %{
    number: 001,
    question: "Write a function called add that takes two numbers and returns their sum",
    solution: """
    def add(x, y) do
      x + y
    end
    """,
    tests: [
      "add(1,2) == 3",
      "add(2,4) == 6",
      "add(2,3) == 5"
    ]
  }
