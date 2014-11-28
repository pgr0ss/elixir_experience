defmodule ElixirProblems.Problem do
  defstruct question: "", answer: ""

  @problems_directory "problems"

  def load_all do
    Enum.map File.ls!(@problems_directory), fn dir -> load_problem(dir) end
  end

  defp load_problem(directory) do
    question = read_file(directory, "question.txt")
    answer = read_file(directory, "answer.txt")
    %ElixirProblems.Problem{question: question, answer: answer}
  end

  defp read_file(directory, filename) do
    Path.join([@problems_directory, directory, filename])
    |> File.read!
    |> String.strip
  end
end
