defmodule ScoresWeb.UserSettingsController do
  use ScoresWeb, :controller

  def edit(conn, _params) do
    render(conn, "edit.html")
  end
end
