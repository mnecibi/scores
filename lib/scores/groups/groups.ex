defmodule Scores.Groups do
  alias Scores.Repo
  alias Scores.Groups.Group
  alias Scores.Groups.GroupInvite
  alias Scores.Accounts
  alias Scores.Accounts.User
  alias Ecto.UUID
  import Ecto.Query
  import ScoresWeb.Gettext

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

      with {:ok, _} <- Accounts.upsert_user_groups(user, group) do
        {:ok, Accounts.get_by_id(user_id)}
      end
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

  @doc """
  Add a group invite.
  """
  @spec add_group_invite(map(), :string) :: {:ok, GroupInvite.t()} | {:error, Ecot.Changeset.t()}
  def add_group_invite(attrs, group_id) do
    Repo.transaction fn ->

      group = Repo.get_by(Group, id: group_id)
      |> Repo.preload(:group_invites)

      new_group_invite = Ecto.build_assoc(group, :group_invites, attrs)

      {:ok, group_invite} = GroupInvite.changeset(new_group_invite, attrs)
      |> Repo.insert()

      group_invite
    end
  end

  @doc """
  Add user to group using invite.
  """
  @spec add_user_to_group(:string, :string) :: {:ok, Group.t()} | {:error, :string}
  def add_user_to_group(invite_id, user_id) do


      case Repo.get_by(GroupInvite, id: invite_id) do
        nil -> {:error, gettext("Invalid invite id")}
        invite ->
          user = Repo.get_by(User, id: user_id)
          |> Repo.preload(:groups)

          group = Repo.get_by(Group, id: invite.group_id)

          invite
          |> Repo.delete()

          with {:ok, group} <- Accounts.upsert_user_groups(user, group) do
            {:ok, group}
          else
            error -> {:error, error}
          end
      end

  end
end
