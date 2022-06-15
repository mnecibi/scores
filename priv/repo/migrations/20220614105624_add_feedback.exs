defmodule Scores.Repo.Migrations.AddFeedback do
  use Ecto.Migration

  def change do
    create table :feedbacks do
      add(:liked, :string)
      add(:disliked, :string)
      add(:to_add, :string)
      add(:score, :string)
      timestamps()
    end
  end
end
