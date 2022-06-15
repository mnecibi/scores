defmodule ScoresWeb.Home do
  use ScoresWeb, :live_view

  def mount(_,_,socket) do
    {:ok, assign(socket, counter: 0)}
  end
end
