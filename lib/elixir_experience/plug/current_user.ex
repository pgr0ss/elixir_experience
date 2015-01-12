defmodule ElixirExperience.Plug.CurrentUser do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
      user_id ->
        user = ElixirExperience.User.find_by_id(user_id)
        conn
        |> put_session(:current_user, user)
        |> assign(:current_user, user)
    end
  end
end
