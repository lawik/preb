defmodule Preb.Repo do
  use Ecto.Repo,
    otp_app: :preb,
    adapter: Ecto.Adapters.Postgres
end
