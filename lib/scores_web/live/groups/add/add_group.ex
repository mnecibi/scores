defmodule ScoresWeb.AddGroup do
  use ScoresWeb, :live_view
  alias Scores.Groups
  alias Scores.Groups.Group

  def mount(_group, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, changeset: Groups.change_group(%Group{}))}
  end

  def handle_event("add_group", %{"group" => params}, socket) do
    case Groups.add_group(params) do
      {:ok, _group} ->
        socket =
          socket
          |> put_flash(:info, "Group successfully created")
          |> push_redirect(to: Routes.live_path(socket, ScoresWeb.Groups))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
