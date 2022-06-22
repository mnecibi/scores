defmodule Scores.Groups.GroupInvite do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "group_invites" do

    belongs_to :group, Scores.Groups.Group

    timestamps()
  end

  @doc """
  Create a changeset to change a group.
  """
  @spec changeset(GroupInvite.t(), map()) :: Ecto.Changeset.t()
  def changeset(group_invite, changes \\ %{}) do
    group_invite
    |> cast(changes, [])
  end
end
