use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :zhora, Zhora.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :zhora, Zhora.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :zhora, Zhora.Repo,
  adapter: RethinkDB.Ecto,
  host: "localhost",
  port: 28015,
  # auth_key: nil,
  db: "zhora_dev",
  pool_size: 10

config :guardian, Guardian,
  secret_key: "LrRzOf0Tsu/1gUl5fa6UOMa6ly6LWw41hmVk1ZfK+U1MHv0n8O5VOJBnNwfnKNzdRGXAbbvNGdU928X6H7q6Sw=="
