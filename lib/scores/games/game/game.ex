defmodule Scores.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :player_1, :string
    field :player_2, :string
    field :player_3, :string
    field :player_4, :string
    field :player_5, :string

    has_many :scores, Scores.Games.Score, on_delete: :delete_all

    belongs_to :group, Scores.Groups.Group

    timestamps()
  end

  @doc """
  Create a changeset to change a game.
  """
  @spec changeset(Game.t(), map()) :: Ecto.Changeset.t()
  def changeset(game, changes \\ %{}) do
    game
    |> cast(changes, [:player_1, :player_2, :player_3, :player_4, :player_5])
    |> validate_required([:player_1, :player_2, :player_3, :player_4, :player_5])
  end
end
