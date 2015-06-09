use Mix.Config
alias ElixirExperience.Problem

config :problems,
  problems: [
  %Problem{
    number: 001,
    question: """
    Write a function called add that takes two numbers and returns their sum, e.g.:
    ```elixir
      add(1, 2) #=> 3
    ```
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
    Write a function num_to_list that takes a number and returns a string from 1 up to the number joined with commas, e.g:
    ```elixir
      num_to_list(10) #=> \"1,2,3,4,5,6,7,8,9,10\"
    ```
    """,
    solution: """
    def num_to_list(n) do
      Enum.join(1..n, \",\")
    end
    """,
    tests: [
      ["num_to_list(10)", "1,2,3,4,5,6,7,8,9,10"],
      ["num_to_list(1)", "1"],
    ]
  },
  %Problem{
    number: 003,
    question: """
    Write a fib function that takes a number and return a list of the first n of fibonacci numbers, e.g:
    ```elixir
      fib(5) #=> [1, 1, 2, 3, 5]
    ```
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

    ```elixir
      concat("foo", "bar") #=> "foobar"
    ```
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
    Write a function palindrome? that checks if a given string is a palindrome. 
    A palindrome is a word, phrase, number, or other sequence of characters which
    reads the same backward or forward, ignoring non-word characters (like spaces, comma, exclamation marks, etc.)
    e.g

    ```elixir
      palindrome?("123,21") #=> true
      palindrome?("Madam, I’m Adam.") #=> true
    ```
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

    ```elixir
    anagram?("rose", "sore") #=> true
    ```
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

    ```elixir
      extract_bytes(<<102, 111, 111, 32, 98, 97, 114, 0, 0, 0, 1>>, 4) #=> "foo "
    ```
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

    ```elixir
      find_missing_char('ZCGBMHFJYTODIUQARVEWPLNKX') #=> ?S
    find_missing_char('abcdefghijklmnopqrstuvwxyz') #=> nil
    ```
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
    Write a checksum function, that computes a [parity byte](http://en.wikipedia.org/wiki/Checksum#Parity_byte_or_parity_word) checksum of a string, e.g:

    ```elixir
      checksum("Elixir is fun.") #=> 95
    ```
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
  %Problem{
    number: 010,
    question: """
    Write a function join that takes a tuple(with elements that of type String, Integer, Float, Atom, CharList) and a separator and returns a string of the elements of the tuple joined by the separator, e.g:

    ```elixir
      join({1,2,3}, " ") #=> "1 2 3"
    ```
    """,
    solution: """
    def join(tuple, separator) do
      tuple |> Tuple.to_list |> Enum.join(separator)
    end
    """,
    tests: [
      ["join({1,2,3}, \" \")", "1 2 3"],
      ["join({:a, :b, :c, :d, :e, :f}, \",\")", "a,b,c,d,e,f"],
      ["join({'2015', '01', '05'}, \"-\")", "2015-01-05"],
    ]
  },
  %Problem{
    number: 011,
    question: """
    Given a list of strings, return a list of list of strings of anagrams, i.e. each element of the returned list is a list of words that are anagrams among them, e.g:

    ```elixir
      input = ["stars", "mary", "rats", "tars", "army", "banana"]
    anagrams(input) #=> [["rats", "tars"], ["army", "mary"], ["stars"], ["banana"]]
    ```
    """,
    solution: """
    def anagrams(input) do
      Enum.reduce(input, %{}, fn(word, acc) ->
        key = word |> to_char_list |> Enum.sort
        Dict.update(acc, key, [word], &([word|&1]))
      end) |> Dict.values
    end
    """,
    tests: [
      [~s/anagrams(["sleet", "slete", "steel", "wran", "warn", "vowel", "wolve"]) |> Enum.map(&(Enum.sort(&1))) |> Enum.sort/, [["sleet", "slete", "steel"], ["vowel", "wolve"], ["warn", "wran"]]],
      [~s/anagrams(["tower", "wrote", "revisit", "visiter", "review", "viewer"]) |> Enum.map(&(Enum.sort(&1))) |> Enum.sort/, [["review", "viewer"], ["revisit", "visiter"], ["tower", "wrote"]]],
      [~s/anagrams(["reweigh", "weigher", "rove", "over", "mixer", "remix", "misread", "sidearm", "agree", "eager"]) |> Enum.map(&(Enum.sort(&1))) |> Enum.sort/, [["agree", "eager"], ["misread", "sidearm"], ["mixer", "remix"], ["over", "rove"], ["reweigh", "weigher"]]]
    ]
  },
  %Problem{
    number: 012,
    question: """
    Write a function `to_hex` that takes an base 10 integer returns a string value of it in [hexadecimal](http://en.wikipedia.org/wiki/Hexadecimal), e.g:

    ```elixir
      to_hex(16) #=> "10"
      to_hex(1023) #=> "3FF"
    ```
    """,
    solution: """
    def to_hex(integer) do
      Integer.to_char_list(integer, 16) |> to_string
    end
    """,
    tests: [
      ["to_hex(16)", "10"],
      ["to_hex(1023)", "3FF"],
      ["to_hex(34510)", "86CE"],
      ["to_hex(2015)", "7DF"],
      ["to_hex(5433559)", "52E8D7"],
    ]
  },
  %Problem{
    number: 013,
    question: """
    Write a function `convert` that takes a string and an list of words and returns a new string with every word in the list that occurs in the original string capitalized

    ```elixir
      convert("People from england are called english", ["england", "english"]) #=> "People from England are called English"
    ```
    """,
    solution: """
    def convert(string, words) do
      Enum.reduce(words, string, fn(word, acc) -> String.replace(acc, word, String.capitalize(word)) end)
    end
    """,
    tests: [
      ["convert(\"People from england are called english\", [\"england\", \"english\"])", "People from England are called English"],
      ["convert(\"jose valim is the author of elixir\", [\"jose\", \"valim\", \"elixir\"])", "Jose Valim is the author of Elixir"],
      ["convert(\"The longest war in history was between the netherlands and the isles of scilly\", [\"netherlands\", \"isles\", \"scilly\"])", "The longest war in history was between the Netherlands and the Isles of Scilly"],
      ["convert(\"albert einstein was offered the role of israel’s second president, albert einstein refused\", [\"albert\", \"einstein\", \"israel\", \"president\"])", "Albert Einstein was offered the role of Israel’s second President, Albert Einstein refused"],
      ["convert(\"harvard university was founded before calculus was invented\", [\"harvard\", \"university\"])", "Harvard University was founded before calculus was invented"],
    ]
  },
  %Problem{
    number: 014,
    question: """
    Write a function `sort` that takes a list of string that contains numbers and sorts them by the number in each string

    ```elixir
      sort(["STRING: 1", "STRING: 05", "STRING: 20", "STRING: 4", "STRING: 3"]) #=> ["STRING: 20", "STRING: 05", "STRING: 4", "STRING: 3", "STRING: 1"]
    ```
    """,
    solution: """
    def sort(words) do
      extract_int = fn(word) -> String.replace(word, ~r/[^\\d]/, "") |> String.to_integer end
      Enum.sort(words, fn word1, word2 -> extract_int.(word1) > extract_int.(word2) end)
    end
    """,
    tests: [
      ["sort([\"STRING: 1\", \"STRING: 05\", \"STRING: 20\", \"STRING: 4\", \"STRING: 3\"])", ["STRING: 20", "STRING: 05", "STRING: 4", "STRING: 3", "STRING: 1"]],
      ["sort([\"A321\", \"B111\", \"C123\"])", ["A321", "C123", "B111"]],
      ["sort([\"Foo 36\", \"Bar 34\", \"Bazz 57\"])", ["Bazz 57", "Foo 36", "Bar 34"]]
    ]
  },
  %Problem{
    number: 015,
    question: """
    Erlang [`:gen_tcp.connect/3`](http://erlang.org/doc/man/gen_tcp.html#connect-3)'s first argument(`Address`) is either an [`:inet.ip_address()`](http://erlang.org/doc/man/inet.html#type-ip_address) which is a tuple of octets or an [`:inet.hostname()`](http://erlang.org/doc/man/inet.html#type-hostname) which is a char_list. Write a function `format_host` that takes a string a returns a valid format for `:gen_tcp.connect`

    ```elixir
      format_host("192.168.0.1") #=> {192, 168, 0, 1}
      format_host("www.example.com") #=> 'www.example.com'
    ```
    """,
    solution: """
    def format_host(host) do
      case Regex.scan(~r/\\d+/, host) do
        [] -> to_char_list(host)
        match_data -> match_data |> List.flatten |> Enum.map(&String.to_integer/1) |> List.to_tuple
      end
    end
    """,
    tests: [
      ["format_host(\"192.168.0.1\")", {192, 168, 0, 1}],
      ["format_host(\"www.example.com\")", 'www.example.com'],
      ["format_host(\"172.168.0.251\")", {172, 168, 0, 251}],
      ["format_host(\"www.foo.com\")", 'www.foo.com'],
    ]
  },
  %Problem{
    number: 016,
    question: """
    Write a function `pmap` that takes a list, a function and an optional timeout in milliseconds, and  a new collection, where each item is the result of invoking function in parallel on each corresponding item of the list, when the function take longer than the specified timeout the atom `:timeout` represents the result, e.g:

    ```elixir
      pmap([1,2,3], fn(x) -> :timer.sleep(3); x + 1 end, 2000) #=> [2,3,:timeout]
    ```
    """,
    solution: """
    def pmap(collection, fun, timeout \\\\ 3000) do
      collection
      |> Enum.map(fn item -> Task.async(fn -> fun.(item) end) end)
      |> Enum.map(fn item ->
        try do
          Task.await(item, timeout)
        catch
          :exit, _ -> :timeout
        end
      end)
    end
    """,
    tests: [
      ["pmap([1,2,3], fn(x) -> :timer.sleep(30); x + 1 end, 20)", [:timeout,3,4]],
      ["pmap([1,2,3], fn(x) -> x + 1 end, 3)", [2,3,4]],
      ["pmap([1,2,3], fn(x) -> :timer.sleep(300); x + 6 end, 200)", [:timeout,8,9]],
      ["pmap([1,2,3], fn(x) -> x * 5 end, 3)", [5,10,15]],
    ]
  },
  %Problem{
    number: 017,
    question: """
    Write a function `hex_to_string` that takes an hexadecimal and returns its string representation, e.g:

    ```elixir
    hex_to_string("2E656D697420656C7474696C206F73202C736B6F6F6220796E616D206F53") #=> "So many books, so little time."
    ```
    """,
    solution: """
    def hex_to_string(hex) do
      hex |>
        to_char_list |>
        Enum.chunk(2) |>
        Enum.map(fn(byte) -> to_string(byte) |> String.to_integer(16) end) |>
        Enum.reduce("", fn(byte, acc) -> <<byte>> <> acc end)
    end
    """,
    tests: [
      ["hex_to_string(\"2E656D697420656C7474696C206F73202C736B6F6F6220796E616D206F53\")", "So many books, so little time."],
      ["hex_to_string(\"2E646C726F7720656874206E6920656573206F74206873697720756F7920746168742065676E61686320656874206542\")", "Be the change that you wish to see in the world."],
      ["hex_to_string(\"2E6C616576657220746F6E2073656F6420656D697420746168742073746572636573206F6E20657261206572656854\")", "There are no secrets that time does not reveal."],
    ]
  },
]
