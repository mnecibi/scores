defmodule ScoresWeb.AddFeedbaclTest do
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "displays form", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/feedbacks/add")

    assert has_element?(view, "form")
    assert has_element?(view, ".add-feedback__title", "Add feedback")
    assert has_element?(view, "label", "What did you like about this app?")
    assert has_element?(view, "label", "What did you dislike about this app?")
    assert has_element?(view, "label", "Think of a feature you would like to see in the future?")
    assert has_element?(view, "label", "Overall, how did you like this app?")
    assert has_element?(view, "button", "Add feedback")
  end

  test "render errors for invalid data", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/feedbacks/add")

    view
    |> element("form")
    |> render_submit()

    assert has_element?(view, "span[phx-feedback-for='feedback[score]']", "can't be blank")
  end

  test "render valid for form with score", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/feedbacks/add")

    view
    |> element("form")
    |> render_submit(%{score: "1"})

    assert has_element?(view, "span[phx-feedback-for='feedback[score]']", "can't be blank")
  end
end
