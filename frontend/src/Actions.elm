module Actions (..) where

import Meals.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | MealsAction Meals.Actions.Action
  | ShowError String
