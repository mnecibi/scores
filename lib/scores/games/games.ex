defmodule Scores.Games do
  alias Scores.Repo
  alias Scores.Games.Score
  alias Scores.Games.Game

  @doc """
  List all games.
  """
  @spec list :: list(Game.t())
  def list do
    Repo.all(Game)
    |> Repo.preload(:scores)
  end

  @doc """
  Get a game by id.
  """
  @spec get(:string) :: Game.t()
  def get(id) do
    Repo.get(Game, id)
    |> Repo.preload(:scores)
  end

  @doc """
  Get the totals for a game.
  """
  @spec totals(:string) :: map()
  def totals(id) do
    get(id).scores
    |> Enum.reduce(%{player_1: 0, player_2: 0, player_3: 0, player_4: 0, player_5: 0}, fn (score, acc) ->
      %{player_1: acc.player_1 + score.player_1,
        player_2: acc.player_2 + score.player_2,
        player_3: acc.player_3 + score.player_3,
        player_4: acc.player_4 + score.player_4,
        player_5: acc.player_5 + score.player_5
      }
    end)
  end

  @doc """
  Create a changeset to change a game.
  """
  @spec change_game(Game.t(), map()) :: Ecto.Changeset.t()
  def change_game(%Game{} = game, changes \\ %{}) do
    Game.changeset(game, changes)
  end


  @doc """
  Add a game score.
  """
  @spec add_game(map()) :: {:ok, Game.t()} | {:error, Ecto.Changeset.t()}
  def add_game(attrs) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a game score.
  """
  @spec update_game(Game.t(), map()) :: {:ok, Game.t()} | {:error, Ecto.Changeset.t()}
  def update_game(%Game{} = game, changes \\ %{}) do
    Game.changeset(game, changes)
    |> Repo.update()
  end

  @doc """
  Delete a game score.
  """
  @spec delete_game(:string) :: {:ok, Game.t()} | {:error, Ecto.Changeset.t()}
  def delete_game(id) do
    Repo.transaction fn ->
      get(id)
      |> Repo.delete()
    end
  end


  @doc """
  Create a changeset to change the game score.
  """
  @spec change_game_score(Score.t(), map()) :: Ecto.Changeset.t()
  def change_game_score(%Score{} = score, changes \\ %{}) do
    Score.changeset(score, changes)
  end


  @doc """
  Update a game score.
  """
  @spec add_score(map(), map()) :: {:ok, Score.t()} | {:error, Ecto.Changeset.t()}
  def add_score(game, attrs) do
    Repo.transaction fn ->

      game = Repo.get_by(Game, id: game.id)
      |> Repo.preload(:scores)

      new_score = Ecto.build_assoc(game, :scores, attrs)

      Score.changeset(new_score, attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Delete a game score.
  """
  @spec delete_score(:string) :: {:ok, Score.t()} | {:error, Ecto.Changeset.t()}
  def delete_score(score_id) do
    Repo.get(Score, score_id)
    |> Repo.delete()
  end
end
