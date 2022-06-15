defmodule ScoresWeb.LocaleTest do
  use ScoresWeb.ConnCase, async: true

  test "default local will be using English", %{conn: conn} do
    conn =
      conn
      |> bypass_through(ScoresWeb.Router, :browser)
      |> get("/")

    assert get_session(conn, :locale) == "en"
    assert %{assigns: %{locale: "en"}} = conn
  end

  test "will accept locale if input from URL params", %{conn: conn} do
    conn =
      conn
      |> bypass_through(ScoresWeb.Router, :browser)
      |> get("/?locale=fr")
      #|> get("/", params: {locale: "fr"})

    assert get_session(conn, :locale) == "fr"
    assert %{assigns: %{locale: "fr"}} = conn
  end

  test "will not accpet unknown locale", %{conn: conn} do
    conn =
      conn
      |> bypass_through(ScoresWeb.Router, :browser)
      |> get("/?locale=unknown")
      #|> get("/", params: {locale: "unknown"})

    assert get_session(conn, :locale) == "en"
    assert %{assigns: %{locale: "en"}} = conn
  end
end
