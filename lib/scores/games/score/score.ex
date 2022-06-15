defmodule Scores.Games.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :player_1, :integer
    field :player_2, :integer
    field :player_3, :integer
    field :player_4, :integer
    field :player_5, :integer

    belongs_to :game, Scores.Games.Game

    timestamps()
  end

  @doc """
  Create a changeset to change a score.
  """
  def changeset(score, attrs, _opts \\ []) do
    score
    |> cast(attrs, [:player_1, :player_2, :player_3, :player_4, :player_5])
    |> validate_required([:player_1, :player_2, :player_3, :player_4, :player_5])
  end
end
