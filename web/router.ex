defmodule Typehero.Router do
  use Typehero.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Typehero do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/texts", TextController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Typehero do
  #   pipe_through :api
  # end
end
