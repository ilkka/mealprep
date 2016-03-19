module Meals.Update (..) where

import Effects exposing (Effects)
import Meals.Models exposing (..)
import Meals.Actions exposing (..)


type alias UpdateModel =
  { meals : List Meal }


update : Action -> UpdateModel -> ( List Meal, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model.meals, Effects.none )
