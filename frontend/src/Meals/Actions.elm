module Meals.Actions (..) where

import Meals.Models exposing (MealId)


type Action
  = NoOp
  | HopAction ()
  | EditMeal MealId
  | ListMeals
