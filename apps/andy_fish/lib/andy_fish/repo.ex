defmodule AndyFish.Repo do
  use Ecto.Repo,
    otp_app: :andy_fish,
    adapter: Ecto.Adapters.Postgres
end
