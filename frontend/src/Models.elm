module Models (..) where

import Meals.Models exposing (Meal)
import Routing


type alias AppModel =
  { meals : List Meal
  , currentMeal : Maybe Meal
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppModel
initialModel =
  { meals = []
  , currentMeal = Nothing
  , routing = Routing.initialModel
  , errorMessage = ""
  }
