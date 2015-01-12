defmodule ElixirExperience.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :auth do
    plug ElixirExperience.Plug.CurrentUser
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/" do
    pipe_through [:browser, :auth]

    get "/", ElixirExperience.PageController, :index
    get "/github_oauth", ElixirExperience.GitHubOAuthController, :oauth
    get "/logout", ElixirExperience.GitHubOAuthController, :logout

    resources "/problems", ElixirExperience.ProblemController
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
