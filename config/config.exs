# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :andy_fish,
  ecto_repos: [AndyFish.Repo]

config :andy_fish_web,
  ecto_repos: [AndyFish.Repo],
  generators: [context_app: :andy_fish]

# Configures the endpoint
config :andy_fish_web, AndyFishWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mYThblURYkk2gLVOMjyIR52TiW6cc982JhLHtLRDaDMGrmowEx39qrwzeTjdXenD",
  render_errors: [view: AndyFishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AndyFishWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
