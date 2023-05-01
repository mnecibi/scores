# Import the necessary modules
import Scores.Game
import Scores.Profile

### CREATE PLAYERS

# Define the list of player data
players_data = [
  %{name: "Player 1", email: "player1@example.com", password: "password1111"},
  %{name: "Player 2", email: "player2@example.com", password: "password2222"},
  %{name: "Player 3", email: "player3@example.com", password: "password3333"},
  %{name: "Player 4", email: "player4@example.com", password: "password4444"},
  %{name: "Player 5", email: "player5@example.com", password: "password5555"}
]

Enum.each(players_data, fn player_data -> register_user(player_data) end)

### CREATE GAMES

# Define the game data and player scores
games_data = [
  %{name: "First Game", player_scores: [%{user_id: 1, score: 10}, %{user_id: 2, score: 20}]},
  %{name: "Second Game", player_scores: [%{user_id: 2, score: 30}, %{user_id: 3, score: 40}]},
  %{name: "Third Game", player_scores: [%{user_id: 3, score: 50}, %{user_id: 4, score: 60}]},
  %{name: "Fourth Game", player_scores: [%{user_id: 4, score: 70}, %{user_id: 5, score: 80}]},
  %{name: "Fifth Game", player_scores: [%{user_id: 5, score: 90}, %{user_id: 1, score: 100}]}
]

Enum.each(games_data, fn game_data -> create_game(game_data.name, game_data.player_scores) end)
