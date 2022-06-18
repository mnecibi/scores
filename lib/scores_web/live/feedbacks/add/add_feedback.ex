defmodule ScoresWeb.AddFeedback do
  use ScoresWeb, :live_view
  alias Scores.Feedbacks
  alias Scores.Feedbacks.Feedback

  def mount(_, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, changeset: Feedbacks.change_feedback(%Feedback{}))}
  end

  def handle_event("add_feedback", %{"feedback" => params}, socket) do
    case Feedbacks.add_feedback(params) do
      {:ok, _feedback} ->
        socket =
          socket
          |> put_flash(:info, "Feedback successfully created")
          |> push_redirect(to: Routes.live_path(socket, ScoresWeb.Feedbacks))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
