defmodule Scores.Game do
  alias Scores.Repo
  alias Scores.Game.Game, as: GameDB

  import Ecto.Query

  def create_game(name, player_scores) do
    game_id = Ecto.UUID.generate()

    player_scores =
      Enum.map(player_scores, fn score ->
        %{game_id: game_id, user_id: score[:user_id], score: score[:score]}
      end)

    game_changeset =
      GameDB.changeset(%{
        game_id: game_id,
        name: name,
        player_scores: player_scores
      })

    case Repo.insert(game_changeset) do
      {:ok, _game} ->
        IO.puts("Inserted game with ID: #{game_id}")

      {:error, changeset} ->
        IO.puts("Failed to insert game with ID: #{game_id}")
        IO.inspect(changeset.errors, label: "Errors:")
    end
  end

  def list_games() do
    from(GameDB,
      order_by: [desc: :inserted_at],
      preload: [player_scores: :player]
    )
    |> Repo.all()
  end
end
