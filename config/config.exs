# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :business_audit_log,
  ecto_repos: [BusinessAuditLog.Repo]

# Configures the endpoint
config :business_audit_log, BusinessAuditLog.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2jvCVQ8kFx3coP6wQRmNpdg4PQwFYFVR3Jl/iHbGlVMilbXp+7UO8qpvMI+IjEGA",
  render_errors: [view: BusinessAuditLog.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BusinessAuditLog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
