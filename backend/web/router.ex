defmodule MealprepBackend.Router do
  use MealprepBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MealprepBackend do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/ingredients", IngredientController, except: [:new, :edit]
      resources "/ingredientclasses", IngredientClassController, except: [:new, :edit]
      resources "/processes", ProcessController, except: [:new, :edit]
      resources "/componentclasses", ComponentClassController, except: [:new, :edit]
    end
  end
end
