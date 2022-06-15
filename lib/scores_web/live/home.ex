defmodule ScoresWeb.Home do
  use ScoresWeb, :live_view

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, counter: 0)}
  end
end
