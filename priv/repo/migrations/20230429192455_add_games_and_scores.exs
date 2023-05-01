defmodule Scores.Repo.Migrations.AddGamesAndScores do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add(:game_id, :uuid, primary_key: true)
      add(:name, :string)

      timestamps()
    end

    create table(:player_scores, primary_key: false) do
      add(:game_id, :uuid, primary_key: true)
      add(:user_id, :integer, primary_key: true)
      add(:score, :integer)

      timestamps()
    end
  end
end
