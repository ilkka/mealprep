module Ingredients.Update (..) where

import Effects exposing (Effects)
import Ingredients.Models exposing (..)
import Ingredients.Actions exposing (..)


type alias UpdateModel =
  { ingredients : List Ingredient
  , errorAddress : Signal.Address String
  }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    FetchAllDone result ->
      case result of
        Ok ingredients ->
          ( { model | ingredients = ingredients }, Effects.none )

        Err error ->
          let
            effects =
              Signal.send model.errorAddress (toString error)
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, effects )

    NoOp ->
      ( model, Effects.none )

    TaskDone () ->
      ( model, Effects.none )
