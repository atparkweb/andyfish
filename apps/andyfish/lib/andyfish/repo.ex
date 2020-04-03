defmodule Andyfish.Repo do
  use Ecto.Repo,
    otp_app: :andyfish,
    adapter: Ecto.Adapters.Postgres
end
