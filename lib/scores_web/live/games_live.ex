defmodule ScoresWeb.GamesLive do
  use ScoresWeb, :live_view

  alias Scores.Game

  @impl true
  def handle_event("toggle_add_game_modal", _params, socket) do
    socket
    |> update(:show_add_game_modal, fn show_add_game_modal -> !show_add_game_modal end)
    |> IO.inspect(label: "#{__ENV__.file}:#{__ENV__.line}")
    |> noreply()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between">
      <div class="font-medium text-3xl"><%= gettext("Games: ") %></div>
      <.button phx-click="toggle_add_game_modal">Add Game</.button>
    </div>
    <div class="flex flex-col">
      <.game :for={game <- @games} game={game} />
    </div>
    <.modal id="add_game" show={@show_add_game_modal} on_cancel={JS.push("toggle_add_game_modal")}>
      Add a game:
    </.modal>
    """
  end

  attr(:game, :map, required: true)

  defp game(assigns) do
    ~H"""
    <div class="border-b last:border-b-0 py-10 px-6">
      <div class="flex flex-col gap-2">
        <div>
          <span class="font-bold"><%= gettext("Name:") %></span>
          <%= @game.name %>
        </div>
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

  attr(:date, :string, required: true)

  defp local_datetime(assigns) do
    ~H"""
    <time datetime={@date} id={Ecto.UUID.generate()} phx-hook="LocalTime"></time>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(games: Game.list_games())
    |> assign(show_add_game_modal: false)
    |> ok()
  end
end
