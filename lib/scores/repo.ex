defmodule Scores.Repo do
  use Ecto.Repo,
    otp_app: :scores,
    adapter: Ecto.Adapters.Postgres
end
