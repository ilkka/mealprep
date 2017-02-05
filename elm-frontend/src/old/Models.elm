module Models (..) where

import Meals.Models
import Ingredients.Models
import Routing


type alias AppState =
  { meals : Meals.Models.State
  , ingredients : Ingredients.Models.State
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppState
initialModel =
  { meals = Meals.Models.initialState
  , ingredients = Ingredients.Models.initialState
  , routing = Routing.initialModel
  , errorMessage = ""
  }
