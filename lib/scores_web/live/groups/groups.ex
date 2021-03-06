defmodule ScoresWeb.Groups do
  use Phoenix.LiveView
  alias Scores.Groups
  alias Scores.Accounts

  import ScoresWeb.Gettext

  def mount(_, %{"locale" => locale, "user_token" => user_token}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, groups: Groups.list(Accounts.get_user_by_session_token(user_token).id))}
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


  def handle_event("add_group_invite", %{"group_id" => group_id}, socket) do
    case Groups.add_group_invite(%{}, group_id) do
      {:ok, group_invite} ->
        socket =
          socket
          |> put_flash(:info, "Group invite has been copied")
          |> push_event("group-invite-created", %{:id => group_invite.id})

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
