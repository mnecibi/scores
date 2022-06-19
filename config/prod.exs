import Config

config :scores, ScoresWeb.Endpoint,
  server: true,
  url: [host: "scores.necibi.com", port: 443, scheme: "https"]

# Do not print debug messages in production
config :logger, level: :info
