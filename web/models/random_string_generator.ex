defmodule ElixirExperience.RandomStringGenerator do
  def generate(string_length \\ 20) do
    :random.seed(:os.timestamp)
    Enum.map(1..string_length, fn _ -> (:random.uniform * 25 + 65) |> round end) |> to_string
  end
end
