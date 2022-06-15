defmodule ScoresWeb.Feedbacks do
  use Phoenix.LiveView
  alias Scores.Feedbacks
  import ScoresWeb.Gettext

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)

    {:ok, assign(socket, feedbacks: Feedbacks.list)}
  end
end
