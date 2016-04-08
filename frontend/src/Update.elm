module Update (..) where

import Models exposing (..)
import Debug
import Actions exposing (..)
import Effects exposing (Effects)
import Routing
import Mailboxes exposing (..)
import Meals.Update
import Meals.Effects


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case (Debug.log "update" action) of
    MealsAction subAction ->
      let
        updateModel =
          { meals = model.meals
          , currentMeal = model.currentMeal
          , errorAddress = Signal.forwardTo actionsMailbox.address ShowError
          , deleteConfirmationAddress = deleteConfirmationMailbox.address
          }

        ( updatedMeals, updatedCurrentMeal, fx ) =
          Meals.Update.update subAction updateModel
      in
        ( { model | meals = updatedMeals, currentMeal = updatedCurrentMeal }, Effects.map MealsAction fx )

    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing

        dataFx =
          case updatedRouting.route of
            Routing.MealShowRoute mealId ->
              Effects.map MealsAction (Meals.Effects.fetchOne mealId)

            _ ->
              Effects.none

        combinedFx =
          Effects.batch [ dataFx, Effects.map RoutingAction fx ]
      in
        ( { model | routing = updatedRouting }, combinedFx )

    ShowError message ->
      ( { model | errorMessage = message }, Effects.none )

    NoOp ->
      ( model, Effects.none )
