defmodule ShortsUrl.Repo do
  use Ecto.Repo,
    otp_app: :shorts_url,
    adapter: Ecto.Adapters.Postgres
end
