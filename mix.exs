defmodule ElixirExperience.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_experience,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirExperience, []},
     applications: [:phoenix, :cowboy, :logger, :oauth2ex]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.8.0"},
     {:cowboy, "~> 1.0"},
     {:earmark, "~> 0.1.12"},
     {:ecto, "~> 0.4"},
     {:ex_spec, "~> 0.3.0", only: :test},
     {:oauth2ex, github: "parroty/oauth2ex"},
     {:postgrex, ">= 0.0.0"}]
  end
end
