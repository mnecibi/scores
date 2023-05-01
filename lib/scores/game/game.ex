defmodule Scores.Game.Game do
  use Ecto.Schema

  alias Scores.Game.PlayerScore

  import Ecto.Changeset

  @primary_key {:game_id, Ecto.UUID, autogenerate: false}
  schema "games" do
    field :name, :string

    has_many :player_scores, PlayerScore, foreign_key: :game_id

    timestamps()
  end

  def changeset(game \\ %__MODULE__{}, params) do
    game
    |> cast(params, [:game_id, :name])
    |> validate_required([:game_id, :name])
    |> cast_assoc(:player_scores)
  end
end
