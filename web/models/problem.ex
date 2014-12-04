defmodule ElixirExperience.Problem do
  defstruct number: 0, question: "", answer: ""

  @problems_directory "problems"

  def load_all do
    File.ls!(@problems_directory)
    |> Enum.sort
    |> Enum.map fn dir -> load_problem(dir) end
  end

  defp load_problem(directory) do
    %ElixirExperience.Problem{
      number: String.to_integer(directory),
      question: read_file(directory, "question.txt"),
      answer: read_file(directory, "answer.txt"),
    }
  end

  defp read_file(directory, filename) do
    Path.join([@problems_directory, directory, filename])
    |> File.read!
    |> String.strip
  end
end
