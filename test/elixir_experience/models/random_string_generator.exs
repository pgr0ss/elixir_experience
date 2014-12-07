defmodule ElixirExperience.RandomStringGeneratorTest do
  use ExUnit.Case, async: true

  test "generate string with default length of 20" do
    random_string = ElixirExperience.RandomStringGenerator.generate
    assert String.length(random_string) == 20
  end

  test "generate string with specified length" do
    random_string = ElixirExperience.RandomStringGenerator.generate(10)
    assert String.length(random_string) == 10
  end

  test "generates random strings" do
    random_strings = Enum.map(1..10, fn _ -> ElixirExperience.RandomStringGenerator.generate end)
    assert length(Enum.uniq(random_strings)) == 10
  end
end
