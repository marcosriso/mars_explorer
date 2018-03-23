defmodule MarsExplorerWeb.Router do
  use MarsExplorerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarsExplorerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/comm", MarsExplorerWeb do
    pipe_through :api # Use the default browser stack

    post "/send", CommController, :receive
  end

  # Other scopes may use custom stacks.
  # scope "/api", MarsExplorerWeb do
  #   pipe_through :api
  # end
end
