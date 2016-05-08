module Models (..) where

import Meals.Models exposing (Meal)
import Ingredients.Models exposing (Ingredient)
import Routing


type alias AppState =
  { meals : List Meal
  , currentMeal : Maybe Meal
  , ingredients : List Ingredient
  , ingredientSearchTerm : Maybe String
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppState
initialModel =
  { meals = []
  , currentMeal = Nothing
  , ingredients = []
  , ingredientSearchTerm = Nothing
  , routing = Routing.initialModel
  , errorMessage = ""
  }
