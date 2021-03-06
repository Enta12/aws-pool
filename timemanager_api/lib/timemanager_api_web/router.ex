defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_auth do
    plug TodolistWeb.JwtAuthPlug
  end

  scope "/api", TodolistWeb do
    pipe_through :api
    #pipe_through :jwt_auth

    resources "/roles", RoleController, except: [:new, :edit]

    scope "/users" do
      post "/signIn", UserController, :signIn
    end

    resources "/users", UserController, except: [:new, :edit]
    resources "/roles", RoleController, except: [:new, :edit]

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
      put "/:userID", ClockController, :update
    end

    scope "/workingtimes" do
      post "/:userID", WorkingtimeController, :create
      get "/:userID", WorkingtimeController, :index
      get "/:userID/:id", WorkingtimeController, :show
    end

    resources "/workingtimes", WorkingtimeController, only: [:update, :delete]

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through [:fetch_session, :protect_from_forgery]
  #     live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
  #   end
  # end
end
