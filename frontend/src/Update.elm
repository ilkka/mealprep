module Update (..) where

import Models exposing (..)
import Debug
import Actions exposing (..)
import Effects exposing (Effects)
import Routing
import Mailboxes exposing (..)
import Meals.Update
import Ingredients.Update
import Meals.Effects


update : Action -> AppState -> ( AppState, Effects Action )
update action model =
  case (Debug.log "update" action) of
    MealsAction subAction ->
      let
        updateModel =
          { meals = model.meals.meals
          , currentMeal = model.meals.currentMeal
          , ingredients = model.ingredients.ingredients
          , ingredientSearchTerm = model.ingredients.searchTerm
          , errorAddress = Signal.forwardTo actionsMailbox.address ShowError
          , deleteConfirmationAddress = deleteConfirmationMailbox.address
          }

        ( updatedModel, fx ) =
          Meals.Update.update subAction updateModel

        oldMeals =
          model.meals

        updatedMeals =
          { oldMeals | meals = updatedModel.meals, currentMeal = updatedModel.currentMeal }
      in
        ( { model | meals = updatedMeals }, Effects.map MealsAction fx )

    IngredientsAction subAction ->
      let
        updateModel =
          { ingredients = model.ingredients.ingredients
          , errorAddress = Signal.forwardTo actionsMailbox.address ShowError
          }

        ( updatedModel, fx ) =
          Ingredients.Update.update subAction updateModel

        oldIngredients =
          model.ingredients

        updatedIngredients =
          { oldIngredients | ingredients = updatedModel.ingredients }
      in
        ( { model | ingredients = updatedIngredients }, Effects.map IngredientsAction fx )

    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update subAction model.routing

        dataFx =
          case updatedRouting.route of
            Routing.MealShowRoute mealId ->
              Effects.map MealsAction (Meals.Effects.fetchOne mealId)

            Routing.MealEditRoute mealId ->
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
