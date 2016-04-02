module Models (..) where

import Meals.Models exposing (Meal)
import Routing


type alias AppModel =
  { meals : List Meal
  , routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  { meals = []
  , routing = Routing.initialModel
  }
