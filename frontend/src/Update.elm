module Update (..) where

import Models exposing (..)
import Debug
import Actions exposing (..)
import Effects exposing (Effects)
import Routing
import Meals.Update


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case (Debug.log "action" action) of
    MealsAction subAction ->
      let
        updateModel =
          { meals = model.meals }

        ( updatedMeals, fx ) =
          Meals.Update.update subAction updateModel
      in
        ( { model | meals = updatedMeals }, Effects.map MealsAction fx )

    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing
      in
        ( { model | routing = updatedRouting }, Effects.map RoutingAction fx )

    NoOp ->
      ( model, Effects.none )
