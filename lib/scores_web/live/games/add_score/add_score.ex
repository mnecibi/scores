defmodule ScoresWeb.AddScore do
  use ScoresWeb, :live_view
  alias Scores.Games
  alias Scores.Games.Score

  def mount(%{"game_id" => id}, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, [changeset: Games.change_game_score(%Score{}), game: Games.get(id)])}
  end

  def handle_event("add_score", %{"score" => params}, socket) do
    case Games.add_score(socket.assigns.game, params) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Score successfully created")
          |> push_redirect(to:  "/groups/"<>to_string(socket.assigns.game.group_id)<>"/"<>to_string(socket.assigns.game.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
