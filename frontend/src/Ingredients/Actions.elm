module Ingredients.Actions (..) where

import Ingredients.Models exposing (Ingredient)
import Http.Extra as HttpExtra exposing (Error, Response)


type Action
  = NoOp
  | FetchAllDone (Result (Error String) (List Ingredient))
  | TaskDone ()
