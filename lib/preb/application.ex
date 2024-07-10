defmodule Preb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PrebWeb.Telemetry,
      Preb.Repo,
      {DNSCluster, query: Application.get_env(:preb, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Preb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Preb.Finch},
      # Start a worker by calling: Preb.Worker.start_link(arg)
      # {Preb.Worker, arg},
      # Start to serve requests, typically the last entry
      PrebWeb.Endpoint,
      Preb.Orchestrator
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Preb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PrebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
