module Actions (..) where

import Meals.Actions


type Action
  = NoOp
  | MealsAction Meals.Actions.Action
