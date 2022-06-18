defmodule ScoresWeb.Game do
  use Phoenix.LiveView
  alias Scores.Games

  import ScoresWeb.Gettext

  def mount(%{"id" => id}, %{"locale" => locale}, socket) do

    Gettext.put_locale(locale)

    socket = socket
      |> assign(game: Games.get(id))
      |> assign(totals: Games.totals(id))

    {:ok, socket}
  end

  def handle_event("delete_score", %{"score_id" => score_id}, socket) do
    case Games.delete_score(score_id) do
      {:ok, _score} ->
        socket =
          socket
          |> put_flash(:info, "Score successfully deleted")
          |> assign(socket, totals: Games.totals(socket.assigns.game.id))
          |> push_redirect(to:  "/games/"<>to_string(socket.assigns.game.id))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
