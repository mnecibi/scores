defmodule ScoresWeb.GamesTest do
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  # TODO update test
  test "check games", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/games")

    assert has_element?(view, "table")
    assert has_element?(view, "thead th", "Player 1:")
    assert has_element?(view, "thead th", "Player 2:")
    assert has_element?(view, "thead th", "Player 3:")
    assert has_element?(view, "thead th", "Player 4:")
    assert has_element?(view, "thead th", "Player 5:")
  end
end
