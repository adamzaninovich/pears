# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pears,
  ecto_repos: [Pears.Repo]

# Configures the endpoint
config :pears, PearsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UIClzqYq9kyfGasWGAR92LVb7nHPwZryvH7sV16fW6TuFubqRUWEtEcFLrfefiQv",
  render_errors: [view: PearsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pears.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [default_scope: "user,public_repo"] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET") 
