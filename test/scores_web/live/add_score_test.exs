defmodule ScoresWeb.AddScoreTest do
  use Scores.DataCase
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  # TODO update tests
  test "displays form", %{conn: conn} do
    existing_user = Factory.insert(:game)
    {:ok, view, _html} = live(conn, "/games/1/add_score")

    assert has_element?(view, "form")
    assert has_element?(view, ".add-score__title", "Add score")
    assert has_element?(view, "label", "Player 1")
    assert has_element?(view, "label", "Player 2")
    assert has_element?(view, "label", "Player 3")
    assert has_element?(view, "label", "Player 4")
    assert has_element?(view, "label", "Player 5")
    assert has_element?(view, "button", "Add score")
  end

  test "render errors for invalid data", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/games/1/add_score")

    view
    |> element("form")
    |> render_submit()

    assert has_element?(view, "span[phx-feedback-for='score[player_1]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='score[player_2]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='score[player_3]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='score[player_4]']", "can't be blank")
    assert has_element?(view, "span[phx-feedback-for='score[player_5]']", "can't be blank")
  end
end
