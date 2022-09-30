defmodule BillCrudWeb.Router do
  use BillCrudWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html", "turbo-html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BillCrudWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug PhoenixTurbo.HandleTurboPlug
    plug :handle_turbo_frame
  end

  pipeline :admins_only do
    plug :admin_basic_auth
  end

  defp admin_basic_auth(conn, _opts) do
    if Mix.env() in [:dev, :test] do
      conn
    else
      username = System.fetch_env!("AUTH_USERNAME")
      password = System.fetch_env!("AUTH_PASSWORD")
      Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BillCrudWeb do
    pipe_through :browser

    get "/", EventController, :index

    resources "/events", EventController do
      resources "/bills", BillController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BillCrudWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development

  scope "/" do
    pipe_through [:browser, :admins_only]
    live_dashboard "/dashboard", metrics: BillCrudWeb.Telemetry, ecto_repos: [BillCrud.Repo]
  end

  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do

  #   scope "/" do
  #     pipe_through :browser

  #     live_dashboard "/dashboard", metrics: BillCrudWeb.Telemetry, ecto_repos: [BillCrud.Repo]
  #   end
  # end

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
end
