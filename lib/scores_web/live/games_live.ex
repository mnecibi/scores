defmodule ScoresWeb.GamesLive do
  use ScoresWeb, :live_view

  alias Scores.Game

  @impl true
  def render(assigns) do
    ~H"""
    <div class="font-medium text-3xl"><%= gettext("Games: ") %></div>
    <div class="flex flex-col">
      <.game :for={game <- @games} game={game} />
    </div>
    """
  end

  attr :game, :map, required: true

  defp game(assigns) do
    ~H"""
    <div class="border-b last:border-b-0 py-10 px-6">
      <div class="flex gap-2">
        <div>
          <span class="font-bold"><%= gettext("Created date:") %></span>
          <.local_datetime date={@game.inserted_at} />
        </div>
      </div>
      <div>
        <div class="grid grid-cols-2 font-bold">
          <div><%= gettext("Player") %></div>
          <div><%= gettext("Score") %></div>
        </div>
        <div :for={player <- @game.player_scores} class="grid grid-cols-2">
          <div><%= player.player.name %></div>
          <div><%= player.score %></div>
        </div>
      </div>
    </div>
    """
  end

  attr :date, :string, required: true

  defp local_datetime(assigns) do
    ~H"""
    <time datetime={@date} id={Ecto.UUID.generate()} phx-hook="LocalTime"></time>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(games: Game.list_games())

    {:ok, socket}
  end
end
