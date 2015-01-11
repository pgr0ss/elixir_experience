defmodule ElixirExperience.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/" do
    pipe_through :browser # Use the default browser stack

    get "/", ElixirExperience.PageController, :index

    resources "/problems", ElixirExperience.ProblemController
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
