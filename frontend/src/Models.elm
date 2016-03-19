module Models (..) where

import Meals.Models exposing (Meal)


type alias AppModel =
  { meals : List Meal }


initialModel : AppModel
initialModel =
  { meals = [ Meal 1 "Sufuruoka" [] ] }
