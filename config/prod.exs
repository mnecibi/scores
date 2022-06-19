import Config

config :scores, ScoresWeb.Endpoint,
  url: [host: "scores.necibi.com", port: 443, scheme: "https"]

# Do not print debug messages in production
config :logger, level: :info
