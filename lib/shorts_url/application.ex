defmodule ShortsUrl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ShortsUrlWeb.Telemetry,
      # Start the Ecto repository
      ShortsUrl.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ShortsUrl.PubSub},
      # Start Finch
      {Finch, name: ShortsUrl.Finch},
      # Start the Endpoint (http/https)
      ShortsUrlWeb.Endpoint
      # Start a worker by calling: ShortsUrl.Worker.start_link(arg)
      # {ShortsUrl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShortsUrl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShortsUrlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
