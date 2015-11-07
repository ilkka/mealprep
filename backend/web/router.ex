defmodule MealprepBackend.Router do
  use MealprepBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MealprepBackend do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/ingredients", IngredientController
    end
  end
end
