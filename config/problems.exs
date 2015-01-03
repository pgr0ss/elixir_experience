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
    Write a function palindrome? that checks if a given string is a palindrome, A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward or forward.  e.g
    palindrome?("madam") #=> true
    """,
    solution: """
    def palindrome?(word) do
      word = String.downcase(word) |> String.replace(~r/\\W+/, "")
      word == String.reverse(word)
    end
    """,
    tests: [
      ["palindrome?(\"A man, a plan, a canal, Panama!\")", true],
      ["palindrome?(\"palindrome\")", false],
      ["palindrome?(\"Amor, Roma\")", true],
      ["palindrome?(\"'Ma,' Jerome raps pot top, 'Spare more jam!'\")", true]
    ]
  },
  %Problem{
    number: 006,
    question: """
    Write a function anagram? that checks if two given strings are anagrams, An anagram is a type of word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once
    anagram?("rose", "sore") #=> true
    """,
    solution: """
    def anagram?(word1, word2) do
      f = &(to_char_list(&1) |> Enum.sort)
      f.(word1) == f.(word2)
    end
    """,
    tests: [
      ["anagram?(\"rose\", \"sore\")", true],
      ["anagram?(\"ruby\", \"bury\")", true],
      ["anagram?(\"foo\", \"bar\")", false],
      ["anagram?(\"bar\", \"baz\")", false],
      ["anagram?(\"marine\", \"remain\")", true],
    ]
  },
  %Problem{
    number: 007,
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
    number: 008,
    question: """
    Write a find_missing_char function that takes a same case alphabetical char list and returns the missing char if there is one otherwise returns nil, e.g:

    find_missing_char('ZCGBMHFJYTODIUQARVEWPLNKX') #=> ?S
    find_missing_char('abcdefghijklmnopqrstuvwxyz') #=> nil
    """,
    solution: """
    def find_missing_char(xs) do
      [x|_] = Enum.sort(xs)
      chars = cond do
        x >= ?a -> Enum.to_list(?a..?z) -- xs
        true -> Enum.to_list(?A..?Z) -- xs
      end
      
      case chars do
        [] -> nil
        [x] -> x
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
  %Problem{
    number: 009,
    question: """
    Write a checksum function, that computes a parity byte checksum of a string (http://en.wikipedia.org/wiki/Checksum#Parity_byte_or_parity_word), e.g:
    checksum("Elixir is fun.") #=> 95
    """,
    solution: """
    use Bitwise
    def checksum(<<head::size(8), rest::binary>>)do
      checksum(head, rest)
    end

    defp checksum(x, <<y::size(8), rest::binary>>) when byte_size(rest) == 0 do
      bxor(x,y)
    end

    defp checksum(x, <<y::size(8), rest::binary>>) do
      bxor(x,y) |> checksum(rest)
    end
    """,
    tests: [
      ["checksum(\"Make it simple. Make it memorable. Make it inviting to look at. Make it fun to read.\")", 13],
      ["checksum(\"What makes things memorable is that they are meaningful, significant, colorful.\")", 26],
      ["checksum(\"Good design is making something intelligible and memorable. Great design is making something memorable and meaningful.\")", 68],
    ]
  },
]
