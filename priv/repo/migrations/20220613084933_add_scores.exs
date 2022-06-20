defmodule Scores.Repo.Migrations.AddScores do
  use Ecto.Migration

  def change do
    create table :scores do
      add(:player_1, :integer, null: false)
      add(:player_2, :integer, null: false)
      add(:player_3, :integer, null: false)
      add(:player_4, :integer, null: false)
      add(:player_5, :integer, null: false)

      add(:game_id, references(:games, on_delete: :nothing))

      timestamps()
    end
  end
end
