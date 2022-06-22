defmodule ScoresWeb.GroupInvite do
  use Phoenix.LiveView
  import ScoresWeb.Gettext

  alias Scores.Groups
  alias Scores.Accounts

  def mount(%{"invite_id" => invite_id}, %{"locale" => locale, "user_token" => user_token}, socket) do
    Gettext.put_locale(locale)

    case Groups.add_user_to_group(invite_id, Accounts.get_user_by_session_token(user_token).id) do

      {:ok, group} ->
        socket = socket
        |> put_flash(:info, gettext("You have been added to the group!"))

        {:ok, assign(socket, :group, group)}

      {:error, error} ->
        {:ok, assign(socket, :error, error)}
    end
  end
end
