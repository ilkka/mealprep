module Ingredients.Actions (..) where

import Ingredients.Models exposing (Ingredient)
import Http


type Action
  = NoOp
  | FetchDone (Result Http.Error (Ingredient))
