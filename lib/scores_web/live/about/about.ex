defmodule ScoresWeb.About do
  use ScoresWeb, :live_view

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, socket}
  end
end
