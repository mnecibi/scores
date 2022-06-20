defmodule ScoresWeb.AddGame do
  use ScoresWeb, :live_view
  alias Scores.Games
  alias Scores.Games.Game
  alias Scores.Groups

  def mount(%{"group_id" => id}, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, [changeset: Games.change_game(%Game{}), group: Groups.get(id)])}
  end

  def handle_event("add_game", %{"game" => params}, socket) do
    case Games.add_game(socket.assigns.group, params) do
      {:ok, _game} ->
        socket =
          socket
          |> put_flash(:info, "Game successfully created")
          |> push_redirect(to: "/groups/"<>to_string(socket.assigns.group.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
