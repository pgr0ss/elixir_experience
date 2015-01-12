defmodule ElixirExperience do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    :ets.new(:session, [:named_table, :public, read_concurrency: true])
    ElixirExperience.Docker.pull_image

    children = [
      # Define workers and child supervisors to be supervised
      # worker(ElixirExperience.Worker, [arg1, arg2, arg3])
      worker(ElixirExperience.Endpoint, []),
      worker(ElixirExperience.ProblemList, []),
      worker(ElixirExperience.Repo, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirExperience.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirExperience.Endpoint.config_change(changed, removed)
    :ok
  end
end

