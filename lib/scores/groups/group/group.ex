defmodule Scores.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Scores.Accounts.User

  schema "groups" do
    field :name, :string

    has_many :games, Scores.Games.Game, on_delete: :delete_all
    has_many :group_invites, Scores.Groups.GroupInvite, on_delete: :delete_all

    many_to_many :users, User, join_through: Scores.UsersGroups, on_replace: :delete

    timestamps()
  end

  @doc """
  Create a changeset to change a group.
  """
  @spec changeset(Group.t(), map()) :: Ecto.Changeset.t()
  def changeset(group, changes \\ %{}) do
    group
    |> cast(changes, [:name])
    |> validate_required([:name])
  end
end
