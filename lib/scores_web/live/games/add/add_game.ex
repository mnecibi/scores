defmodule ScoresWeb.AddGame do
  use ScoresWeb, :live_view
  alias Scores.Games
  alias Scores.Games.Game

  def mount(_game, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, changeset: Games.change_game(%Game{}))}
  end

  def handle_event("add_game", %{"game" => params}, socket) do
    case Games.add_game(params) do
      {:ok, _game} ->
        socket =
          socket
          |> put_flash(:info, "Game successfully created")
          |> redirect(to: Routes.live_path(socket, ScoresWeb.Games))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
