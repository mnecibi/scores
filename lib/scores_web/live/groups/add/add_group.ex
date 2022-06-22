defmodule ScoresWeb.AddGroup do
  use ScoresWeb, :live_view
  alias Scores.Groups
  alias Scores.Groups.Group
  alias Scores.Accounts

  def mount(_group, %{"locale" => locale, "user_token" => user_token}, socket) do
    Gettext.put_locale(locale)

    {:ok,
      assign(socket, [
        changeset: Groups.change_group(%Group{}),
        current_user:  Accounts.get_user_by_session_token(user_token)
      ])
    }
  end

  def handle_event("add_group", %{"group" => params}, socket) do
    case Groups.add_group(params, socket.assigns.current_user.id) do
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
