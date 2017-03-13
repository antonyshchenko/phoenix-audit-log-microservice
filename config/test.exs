use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :business_audit_log, BusinessAuditLog.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :business_audit_log, BusinessAuditLog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "business_audit_log_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :business_audit_log, BusinessAuditLog.AuditLog.SqsListener,
  queue: System.get_env("QUEUE_NAME")

config :ex_aws,
  debug_requests: false,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role],
  region: "eu-west-1"

