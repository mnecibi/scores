defmodule ScoresWeb.AddScore do
  use ScoresWeb, :live_view
  alias Scores.Games
  alias Scores.Games.Score

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, [changeset: Games.change_game_score(%Score{}), game: Games.get(id)])}
  end

  def handle_event("add_score", %{"score" => params}, socket) do
    case Games.add_score(socket.assigns.game, params) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Score successfully created")
          |> redirect(to:  "/games/"<>to_string(socket.assigns.game.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
