defmodule MealprepBackend.Router do
  use MealprepBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MealprepBackend do
    pipe_through :api
  end
end
