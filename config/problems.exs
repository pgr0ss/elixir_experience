use Mix.Config
alias ElixirExperience.Problem

config :problems,
  problems: [
  %Problem{
    number: 001,
    question: """
    Write a function called add that takes two numbers and returns their sum, e.g.:

    add(1, 2) #=> 3
    """,
    solution: """
    def add(x, y) do
      x + y
    end
    """,
    tests: [
      ["add(1, 1)", 2],
      ["add(3, 6)", 9],
      ["add(4, 4)", 8],
    ]
  },
  %Problem{
    number: 002,
    question: """
    Write a function num2list that takes a number and returns a string from 1 up to the number joined with commas, e.g:

    num2list(10) #=> \"1,2,3,4,5,6,7,8,9,10\"
    """,
    solution: """
    def num2list(n) do
      Enum.join(1..n, \",\")
    end
    """,
    tests: [
      ["num2list(10)", "1,2,3,4,5,6,7,8,9,10"],
      ["num2list(1)", "1"],
    ]
  },
  %Problem{
    number: 003,
    question: """
    Write a fib function that takes a number and return a list of the first n of fibonacci numbers, e.g:

    fib(5) #=> [1, 1, 2, 3, 5]
    """,
    solution: """
      def fib(num) do
        Stream.unfold({1, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(num)
      end
    """,
    tests: [
      ["fib(2)", [1, 1]],
      ["fib(5)", [1, 1, 2, 3, 5]],
    ]
  },
  %Problem{
    number: 004,
    question: """
    Write a concat function that takes two strings(binaries) and concantenates them, e.g:

    concat("foo", "bar") #=> "foobar"
    """,
    solution: """
      def concat(word1, word2) do
        word1 <> word2
      end
    """,
    tests: [
      ["concat(\"foo\", \"bar\")", "foobar"],
      ["concat(<<1>>, <<2>>)", <<1, 2>>],
      ["concat(\"a\", <<2>>)", <<97, 2>>],
    ]
  },
  %Problem{
    number: 005,
    question: """
    Write an extract_bytes function that takes a binary and a non-negative integer and extracts the number of bytes specified by the integer, e.g:

    extract_bytes(<<102, 111, 111, 32, 98, 97, 114, 0, 0, 0, 1>>, 4) #=> "foo "
    """,
    solution: """
    def extract_bytes(bin, int) do
      <<bytes :: size(int)-binary, rest :: binary >> = bin
      bytes
    end
    """,
    tests: [
      ["extract_bytes(<<102, 111, 111, 32, 98, 97, 114, 0, 0, 0, 1>>, 4)", "foo "],
      ["extract_bytes(<<101, 108, 105, 120, 105, 114, 32, 0, 1, 115, 32, 110, 105, 99, 101, 46>>, 6)", "elixir"],
      ["extract_bytes(\"binaries\", 3)", "bin"],
    ]
  },
  %Problem{
    number: 006,
    question: """
    Write a find_missing_char function that takes a same case alphabetical char list and returns the missing char if there is one otherwise returns nil, e.g:

    find_missing_char('ZCGBMHFJYTODIUQARVEWPLNKX') #=> ?S
    find_missing_char('abcdefghijklmnopqrstuvwxyz') #=> nil
    """,
    solution: """
    def find_missing_char(xs) do
      [x|ys] = Enum.sort(xs)
      cond do
        x > ?a -> ?a
        x > ?A && x < 91 -> ?A
        true -> find_missing_char_helper(ys, x)
      end
    end

    defp find_missing_char_helper(xs, _) when length(xs) == 1, do: nil
    defp find_missing_char_helper([x|xs], y) do
      if (y + 1) != x do
        y + 1
      else
        find_missing_char_helper(xs, x)
      end
    end
    """,
    tests: [
     ["find_missing_char('ZCGBMHFJYTODIUQARVEWPLNKX')", ?S],
     ["find_missing_char('ROPHITNBXLUYJSQKGCFEWDZMV')", ?A],
     ["find_missing_char('abcdefghijklmnopqrstuvwxyz')", nil],
     ["find_missing_char('ABCDEFGHIJKLMNOPQRSTUVWXYZ')", nil],
     ["find_missing_char('ouetfgjvysqwpzrahxicbnmdl')", ?k],
     ["find_missing_char('ulvswmbzfgnrjepodyixthcqk')", ?a],
    ]
  },
]
