defmodule PearsWeb.Router do
  use PearsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  scope "/", PearsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/images", ImageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PearsWeb do
  #   pipe_through :api
  # end
end
