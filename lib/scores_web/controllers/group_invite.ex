defmodule ScoresWeb.GroupInviteController do
  import Plug.Conn
  import Phoenix.Controller
  use ScoresWeb, :controller

  alias Scores.Groups

  def request(%{assigns: %{:current_user => current_user}} = conn, %{"invite_id" => invite_id}) do

    case Groups.add_user_to_group(invite_id, current_user.id) do
      {:ok, group} ->
        conn
        |> put_flash(:info, gettext("You have been added to the group: ") <> group.name)
        |> redirect(to: "/groups")

      _ ->
        conn
        |> put_flash(:error, "Group id invalid")
        |> redirect(to: "/groups")
    end
  end
end
