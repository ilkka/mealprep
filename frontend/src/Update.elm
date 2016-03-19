module Update (..) where

import Models exposing (..)
import Actions exposing (..)
import Effects exposing (Effects)
import Meals.Update


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case action of
    MealsAction subAction ->
      let
        updateModel =
          { meals = model.meals }

        ( updatedMeals, fx ) =
          Meals.Update.update subAction updateModel
      in
        ( { model | meals = updatedMeals }, Effects.map MealsAction fx )

    NoOp ->
      ( model, Effects.none )
