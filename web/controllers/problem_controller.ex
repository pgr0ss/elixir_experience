defmodule ElixirExperience.ProblemController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html", number_of_problems: ElixirExperience.ProblemList.number_of_problems
  end

  def show(conn, %{"id" => id_string}) do
    {id, _} = Integer.parse(id_string)
    render conn, "show.html", problem: ElixirExperience.ProblemList.get_problem(id)
  end

  def update(conn, %{"id" => id_string, "code" => code}) do
    {id, _} = Integer.parse(id_string)
    current_user = conn.assigns[:current_user]
    problem = ElixirExperience.ProblemList.get_problem(id)
    {result, output} = ElixirExperience.CodeRunner.run(code, problem)
    if result == :passed && current_user do
      ElixirExperience.User.create_solution(current_user, problem, code)
    end
    render conn, "results.html", problem: problem, code: code, result: result, output: output
  end
end
