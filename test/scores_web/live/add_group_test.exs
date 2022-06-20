defmodule ScoresWeb.AddgroupTest do
  use ScoresWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  # TODO update tests
  test "displays form", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/groups/add")

    assert has_element?(view, "form")
    assert has_element?(view, ".add-group__title", "Add group")
    assert has_element?(view, "label", "Name")
    assert has_element?(view, "button", "Add group")
  end

  test "render errors for invalid data", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/groups/add")

    view
    |> element("form")
    |> render_submit()

    assert has_element?(view, "span[phx-feedback-for='group[name]']", "can't be blank")
  end
end
