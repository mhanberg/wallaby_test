# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wallaby_test,
  ecto_repos: [WallabyTest.Repo]

# Configures the endpoint
config :wallaby_test, WallabyTest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZXmMeyrHu1nFPK8mWOWCAtaN1KY/6dUgisXGNxDy3+01p1zVDctb2zfOHmwUebSM",
  render_errors: [view: WallabyTest.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WallabyTest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
