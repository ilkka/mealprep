module Ingredients.Update (..) where

import Effects exposing (Effects)
import Ingredients.Models exposing (..)
import Ingredients.Actions exposing (..)


type alias UpdateModel =
  { ingredients : List Ingredient }


update : Action -> UpdateModel -> ( List Ingredient, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model.ingredients, Effects.none )
