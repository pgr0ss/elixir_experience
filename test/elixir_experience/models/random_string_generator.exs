defmodule ElixirExperience.RandomStringGeneratorTest do
  use ExSpec, async: true

  alias ElixirExperience.RandomStringGenerator

  describe "generate" do
    it "generates a string with default length of 20" do
      random_string = RandomStringGenerator.generate
      assert String.length(random_string) == 20
    end

    it "generates a string with specified length" do
      random_string = RandomStringGenerator.generate(10)
      assert String.length(random_string) == 10
    end

    it "generates random strings" do
      random_strings = Enum.map(1..10, fn _ -> RandomStringGenerator.generate end)
      assert length(Enum.uniq(random_strings)) == 10
    end
  end
end
