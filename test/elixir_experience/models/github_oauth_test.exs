defmodule ElixirExperience.GitHubOAuthTest do
  use ExSpec, async: true

  alias ElixirExperience.GitHubOAuth

  describe "authorize_url" do
    it "containss client_id" do
      assert String.starts_with?(GitHubOAuth.authorize_url, "https://github.com/login/oauth/authorize?client_id=8564df8d0cc88bff6796")
    end

    it "contains redirect_uri" do
      assert String.contains?(GitHubOAuth.authorize_url, URI.encode_query(redirect_uri: "http://localhost:4001/github_oauth"))
    end
  end
end
