defmodule AndyFishWeb.Router do
  use AndyFishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AndyFishWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AndyFishWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AndyFishWeb do
  #   pipe_through :api
  # end
end
