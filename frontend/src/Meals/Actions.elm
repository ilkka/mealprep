module Meals.Actions (..) where

import Meals.Models exposing (MealId)
import Hop


type Action
  = NoOp
  | HopAction ()
  | EditMeal MealId
