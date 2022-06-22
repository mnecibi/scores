defmodule Scores.Repo.Migrations.AddUsersGroups do
  use Ecto.Migration

  def change do

    create table(:users_groups) do
      add(:group_id, references(:groups, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:users_groups, [:group_id]))
    create(index(:users_groups, [:user_id]))
  end
end
