defmodule ElixirExperience.GitHubOAuthController do
  use Phoenix.Controller

  plug :action

  alias ElixirExperience.GitHubOAuth

  def oauth(conn, %{"code" => code}) do
    user = GitHubOAuth.user(code)
    text conn, inspect(user)
  end
end
