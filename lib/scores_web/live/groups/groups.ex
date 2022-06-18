defmodule ScoresWeb.Groups do
  use Phoenix.LiveView
  alias Scores.Groups

  import ScoresWeb.Gettext

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, groups: Groups.list)}
  end

  def handle_event("delete_group", %{"group_id" => group_id}, socket) do
    case Groups.delete_group(group_id) do
      {:ok, _} ->
        socket =
          socket
          |> put_flash(:info, "Group successfully deleted")
          |> push_redirect(to:  "/groups")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
