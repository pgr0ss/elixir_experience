defmodule ElixirExperience.GitHubOAuthController do
  use Phoenix.Controller

  plug :action

  alias ElixirExperience.GitHubOAuth
  alias ElixirExperience.User

  def oauth(conn, %{"code" => code}) do
    user = GitHubOAuth.user(code)

    conn
    |> put_session(:user_id, User.insert_unless_exists(user).id)
    |> redirect(to: "/")
  end
end
