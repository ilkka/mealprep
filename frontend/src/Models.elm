module Models (..) where

import Meals.Models exposing (Meal, MealIngredient)
import Ingredients.Models exposing (Ingredient)
import Routing


type alias AppModel =
  { meals : List Meal
  , routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  { meals =
      [ Meal
          1
          "Sufuruoka"
          [ MealIngredient (Ingredient 1 "Mako") 5
          , MealIngredient (Ingredient 2 "Hajo") 2
          ]
      ]
  , routing = Routing.initialModel
  }
