defmodule Scores.Feedbacks.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedbacks" do
    field :liked, :string
    field :disliked, :string
    field :to_add, :string
    field :score, :string

    timestamps()
  end

  @doc """
  Create a changeset to change a feedback.
  """
  @spec changeset(Feedback.t(), map()) :: Ecto.Changeset.t()
  def changeset(feedback, changes \\ %{}) do
    feedback
    |> cast(changes, [:liked, :disliked, :to_add, :score])
    |> validate_required([:score])
  end
end
