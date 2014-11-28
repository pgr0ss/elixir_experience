defmodule ElixirProblems.ProblemController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", number_of_problems: ElixirProblems.ProblemList.number_of_problems
  end

  def show(conn, %{"id" => id_string}) do
    {id, _} = Integer.parse(id_string)
    render conn, "show.html", id: id, problem: ElixirProblems.ProblemList.get_problem(id)
  end

  def update(conn, %{"id" => id_string, "code" => code}) do
    {id, _} = Integer.parse(id_string)
    problem = ElixirProblems.ProblemList.get_problem(id)
    {output, exit_code} = ElixirProblems.Docker.run(code)
    render conn, "results.html", id: id, code: code, output: output, correct: output == problem.answer
  end
end
