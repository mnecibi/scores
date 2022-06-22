defmodule Scores.UsersGroups do
  use Ecto.Schema

  schema "users_groups" do
    field :user_id, :binary_id
    field :group_id, :integer
    timestamps()
  end
end
