defmodule Scores.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scores.Groups.Group

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :confirmed_at, :naive_datetime

    many_to_many :groups, Group, join_through: Scores.UsersGroups, on_replace: :delete

    timestamps()
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of the email.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour..
  """
  def registration_changeset(user, attrs, _opts \\ []) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Scores.Repo)
    |> unique_constraint(:email)
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end


  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end


  def changeset_update_groups(user, group) do
    user
    |> cast(%{}, [:email])
    |> put_assoc(:groups, group)
  end
end
