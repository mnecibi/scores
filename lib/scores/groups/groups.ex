defmodule Scores.Groups do
  alias Scores.Repo
  alias Scores.Groups.Group

  @doc """
  List all groups.
  """
  @spec list :: list(Group.t())
  def list do
    Repo.all(Group)
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
  @spec add_group(map()) :: {:ok, Group.t()} | {:error, Ecto.Changeset.t()}
  def add_group(attrs) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
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
