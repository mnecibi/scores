defmodule Scores.Repo.Migrations.AddGroups do
  use Ecto.Migration

  def change do
    create table :groups do
      add(:name, :string)
      timestamps()
    end
  end
end
