defmodule ElixirProblems.ProblemController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", id: id
  end
end
