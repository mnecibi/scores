defmodule ScoresWeb.GroupsTest do
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "check groups", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/groups")

    assert has_element?(view, "table")
    assert has_element?(view, "thead th", "Name:")
  end
end
