defmodule KuukuuWeb.Router do
  use KuukuuWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KuukuuWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KuukuuWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/threads", ThreadLive.Index, :index
    live "/threads/new", ThreadLive.Index, :new
    live "/threads/:id/edit", ThreadLive.Index, :edit

    live "/threads/:id", ThreadLive.Show, :show
    live "/threads/:id/show/edit", ThreadLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", KuukuuWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:kuukuu, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KuukuuWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
