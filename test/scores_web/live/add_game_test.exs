defmodule ScoresWeb.AddGameTest do
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "displays form", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/games/add")

    assert has_element?(view, "form")
    assert has_element?(view, ".add-game__title", "Add game")
    assert has_element?(view, "label", "Player 1")
    assert has_element?(view, "label", "Player 2")
    assert has_element?(view, "label", "Player 3")
    assert has_element?(view, "label", "Player 4")
    assert has_element?(view, "label", "Player 5")
    assert has_element?(view, "button", "Add game")
  end

  test "render errors for invalid data", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/games/add")

    view
    |> element("form")
    |> render_submit()

    assert has_element?(view, "span[phx-feedback-for='game[player_1]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='game[player_2]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='game[player_3]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='game[player_4]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='game[player_5]']", "can't be blank")
  end
end
