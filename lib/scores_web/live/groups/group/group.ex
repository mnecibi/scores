defmodule ScoresWeb.Group do
  use Phoenix.LiveView
  alias Scores.Games.Game
  alias Scores.Games
  alias Scores.Groups

  import ScoresWeb.Gettext

  def mount(%{"group_id" => id}, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, [changeset: Games.change_game(%Game{}), group: Groups.get(id)])}
  end

  def handle_event("delete_game", %{"game_id" => game_id}, socket) do
    case Games.delete_game(game_id) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Game successfully deleted")
          |> push_redirect(to: "/groups/"<>to_string(socket.assigns.group.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
