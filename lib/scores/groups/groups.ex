defmodule Scores.Groups do
  alias Scores.Repo
  alias Scores.Groups.Group
  alias Scores.Accounts
  alias Ecto.UUID
  import Ecto.Query

  @doc """
  List all groups.
  """
  @spec list(:string) :: list(Group.t())
  def list(user_id) do

    {:ok, user_id} = UUID.dump(user_id);

    query = from ug in "users_groups",
        where: ug.user_id == ^user_id,
        left_join: group in Group,
        on: group.id == ug.group_id,
        select: group

    Repo.all(query)

  end

  @doc """
  Get a group by id.
  """
  @spec get(:string) :: Group.t()
  def get(id) do
    Repo.get(Group, id)
    |> Repo.preload(:games)
  end

  @doc """
  Create a changeset to change a group.
  """
  @spec change_group(Group.t(), map()) :: Ecto.Changeset.t()
  def change_group(%Group{} = group, changes \\ %{}) do
    Group.changeset(group, changes)
  end


  @doc """
  Add a group.
  """
  @spec add_group(map(), :string) :: {:ok, Group.t()} | {:error, Ecto.Changeset.t()}
  def add_group(attrs, user_id) do
    Repo.transaction fn ->

      user = Accounts.get_by_id(user_id)

      {:ok, group} = %Group{}
      |> Group.changeset(attrs)
      |> Repo.insert()

      Accounts.upsert_user_groups(user, group)
    end
  end

  @doc """
  Update a group.
  """
  @spec update_group(Group.t(), map()) :: {:ok, Group.t()} | {:error, Ecto.Changeset.t()}
  def update_group(%Group{} = group, changes \\ %{}) do
    Group.changeset(group, changes)
    |> Repo.update()
  end

  @doc """
  Delete a group.
  """
  @spec delete_group(:string) :: {:ok, Group.t()} | {:error, Ecto.Changeset.t()}
  def delete_group(id) do
    Repo.transaction fn ->
      get(id)
      |> Repo.delete()
    end
  end
end
