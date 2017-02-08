defmodule MealprepBackend.Router do
  use MealprepBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    #plug :fetch_session
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", MealprepBackend do
    pipe_through :browser
    get "/", FrontendController, :index
  end

  scope "/api", MealprepBackend do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/ingredients", IngredientController, except: [:new, :edit]
      resources "/ingredientclasses", IngredientClassController, except: [:new, :edit]
      get "/ingredientclasses/:id/subclasses", IngredientClassController, :subclasses
      resources "/processes", ProcessController, except: [:new, :edit]
      resources "/componentclasses", ComponentClassController, except: [:new, :edit]
      resources "/units", UnitController, except: [:new, :edit]
      resources "/components", ComponentController, except: [:new, :edit]
      resources "/componentvalues", ComponentValueController, except: [:new, :edit]
      resources "/meals", MealController
    end
  end
end
