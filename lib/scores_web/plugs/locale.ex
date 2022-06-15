defmodule ScoresWeb.Locale do
  import Plug.Conn, only: [ put_session: 3, assign: 3, get_session: 2 ]
  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(%{params: %{"locale" => locale}} = conn, _opts) when locale in ["en", "fr"] do
    setup_locale(conn, locale)
  end

  def call(conn, _opts) do
    case get_session(conn, :locale) do
      nil ->
        setup_locale(conn, "en")
      "fr" ->
        setup_locale(conn, "fr")
      _ ->
        setup_locale(conn, "en")
    end
    setup_locale(conn, "en")
  end

  def setup_locale(conn, locale) do
    Gettext.put_locale(locale)

    conn
    |> put_session(:locale, locale)
    |> assign(:locale, locale)
  end
end
