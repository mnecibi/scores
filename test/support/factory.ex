defmodule Scores.Factory do
  use ExMachina.Ecto, repo: Scores.Ecto
  alias Scores.Games.Game
  alias Scores.Games.Score

  def game_factory do
    %Game{
      player_1: "Mehdi",
      player_2: "Sebastien",
      player_3: "Nicolas",
      player_4: "Pierre",
      player_5: "Julien"
    }
  end

  def score_factory do
    %Score{
      player_1: 50,
      player_2: 100,
      player_3: -50,
      player_4: -50,
      player_5: -50
    }
  end
end
