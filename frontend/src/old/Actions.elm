module Actions (..) where

import Meals.Actions
import Ingredients.Actions
import Routing


type Action
  = NoOp
  | RoutingAction Routing.Action
  | MealsAction Meals.Actions.Action
  | IngredientsAction Ingredients.Actions.Action
  | ShowError String
