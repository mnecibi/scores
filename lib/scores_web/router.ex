defmodule ScoresWeb.Router do
  use ScoresWeb, :router

  import ScoresWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ScoresWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ScoresWeb.Locale
    plug :fetch_current_user
  end

  scope "/", ScoresWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", Home
    live "/about", About

    live "/groups", Groups
    live "/groups/add", AddGroup

    get "/groups/invites/:invite_id", GroupInviteController, :request

    live "/groups/:group_id", Group
    live "/groups/:group_id/add_game", AddGame
    live "/groups/:group_id/:game_id", Game
    live "/groups/:group_id/:game_id/add_score", AddScore

    live "/feedbacks", Feedbacks
    live "/feedbacks/add", AddFeedback
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScoresWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ScoresWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes
  scope "/", ScoresWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/auth/:provider", UserOauthController, :request
    get "/auth/:provider/callback", UserOauthController, :callback

    get "/users/register", UserRegistrationController, :new
    get "/users/log_in", UserSessionController, :new
  end

  scope "/", ScoresWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", ScoresWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
