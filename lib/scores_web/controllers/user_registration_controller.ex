defmodule ScoresWeb.UserRegistrationController do
  use ScoresWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
