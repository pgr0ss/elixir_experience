defmodule ElixirExperience.GitHubOAuth do
  def authorize_url do
    OAuth2Ex.get_authorize_url(config)
  end

  def user(code) do
    access_token = access_token(code)
    response = OAuth2Ex.HTTP.get(access_token, "https://api.github.com/user")
    map_to_user(response.body)
  end

  defp access_token(code) do
    OAuth2Ex.get_token(config, code)
  end

  defp config do
    OAuth2Ex.config(
      id:            app_config[:client_id],
      secret:        app_config[:client_secret],
      authorize_url: "https://github.com/login/oauth/authorize",
      token_url:     "https://github.com/login/oauth/access_token",
      scope:         "",
      callback_url:  redirect_url,
    )
  end

  defp map_to_user(fields) do
    %ElixirExperience.User{
      avatar_url: fields["avatar_url"],
      email: fields["email"],
      github_id: fields["id"],
      login: fields["login"],
    }
  end

  defp redirect_url do
    ElixirExperience.Router.Helpers.git_hub_o_auth_url(ElixirExperience.Endpoint, :oauth)
  end

  defp app_config do
    Application.get_env(:elixir_experience, :github_oauth)
  end
end
