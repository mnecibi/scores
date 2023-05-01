defmodule Scores.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ScoresWeb.Telemetry,
      # Start the Ecto repository
      Scores.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Scores.PubSub},
      # Start Finch
      {Finch, name: Scores.Finch},
      # Start the Endpoint (http/https)
      ScoresWeb.Endpoint
      # Start a worker by calling: Scores.Worker.start_link(arg)
      # {Scores.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scores.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScoresWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
