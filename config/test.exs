use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :zhora, Zhora.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :zhora, Zhora.Repo,
  adapter: RethinkDB.Ecto,
  host: "localhost",
  port: 28015,
  # auth_key: nil,
  db: "zhora_test",
  pool_size: 10
