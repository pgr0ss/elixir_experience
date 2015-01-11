defmodule ElixirExperience.LayoutView do
  use ElixirExperience.View

  def github_login_url do
    ElixirExperience.GitHubOAuth.authorize_url
  end
end
