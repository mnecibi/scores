defmodule Scores.Repo.Migrations.AddGroupInvite do
  use Ecto.Migration

  def change do
    create table(:group_invites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :group_id, references(:groups, on_delete: :delete_all)
      timestamps()
    end
  end
end
