defmodule Scores.Game.PlayerScore do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  schema "player_scores" do
    field :game_id, Ecto.UUID, primary_key: true
    field :user_id, :integer, primary_key: true
    field :score, :integer

    has_one :player, Scores.Profile.User, foreign_key: :id, references: :user_id

    timestamps()
  end

  def changeset(score \\ %__MODULE__{}, attrs) do
    score
    |> cast(attrs, [:game_id, :user_id, :score])
  end
end
