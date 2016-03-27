module Models (..) where

import Meals.Models exposing (Meal)
import Routing


type alias AppModel =
  { meals : List Meal
  , routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  { meals = [ Meal 1 "Sufuruoka" [] ]
  , routing = Routing.initialModel
  }
