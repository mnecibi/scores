defmodule ScoresWeb.Games do
  use Phoenix.LiveView
  alias Scores.Games

  import ScoresWeb.Gettext

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, games: Games.list)}
  end

  def handle_event("delete_game", %{"game_id" => game_id}, socket) do
    case Games.delete_game(game_id) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Game successfully deleted")
          |> push_redirect(to:  "/games")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
