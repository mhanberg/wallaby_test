use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wallaby_test, WallabyTest.Endpoint,
  http: [port: 4001],
  server: true

config :wallaby_test, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :wallaby_test, WallabyTest.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "wallaby_test_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
