defmodule ScoresWeb.Feedbacks do
  use Phoenix.LiveView
  import Phoenix.LiveView.Router
  alias Scores.Feedbacks

  def mount(_feedbacks, _, socket) do
    {:ok, assign(socket, feedbacks: Feedbacks.list)}
  end
end
