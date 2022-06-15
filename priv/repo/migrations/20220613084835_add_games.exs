defmodule Scores.Repo.Migrations.AddGames do
  use Ecto.Migration

  def change do
    create table :games do
      add(:player_1, :string, null: false)
      add(:player_2, :string, null: false)
      add(:player_3, :string, null: false)
      add(:player_4, :string, null: false)
      add(:player_5, :string, null: false)
      timestamps()
    end
  end
end
