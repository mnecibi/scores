defmodule Scores.Feedbacks do
  alias Scores.Repo
  alias Scores.Feedbacks.Feedback

  @doc """
  List all feedbacks.
  """
  @spec list :: list(Feedback.t())
  def list do
    Repo.all(Feedback)
  end

  @doc """
  Create a changeset to change a feedback.
  """
  @spec change_feedback(Feedback.t(), map()) :: Ecto.Changeset.t()
  def change_feedback(%Feedback{} = feedback, changes \\ %{}) do
    Feedback.changeset(feedback, changes)
  end

  @doc """
  Add a feedback.
  """
  @spec add_feedback(map()) :: {:ok, Feedback.t()} | {:error, Ecto.Changeset.t()}
  def add_feedback(attrs) do
    %Feedback{}
    |> Feedback.changeset(attrs)
    |> Repo.insert()
  end
end
