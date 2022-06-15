defmodule ScoresWeb.Games do
  use Phoenix.LiveView
  alias Scores.Games

  def mount(_games, _, socket) do
    {:ok, assign(socket, games: Games.list)}
  end

  def handle_event("delete_game", %{"game_id" => game_id}, socket) do
    case Games.delete_game(game_id) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Game successfully deleted")
          |> redirect(to:  "/games")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


end
