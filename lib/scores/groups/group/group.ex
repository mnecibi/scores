defmodule Scores.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string

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
