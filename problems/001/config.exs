use Mix.Config

config :"001",
  problem: %{
    number: 001,
    answer: "42",
    question: """
  Write an elixir program that prints the number 42 to stdout.
    """,
    solution: "IO.puts 42",
    runner: "",
    tests: []
  }
