module View (..) where

import Models exposing (..)
import Actions exposing (..)
import Html exposing (..)
import Routing
import Meals.List
import Meals.Edit
import Meals.Models exposing (MealId)


view : Signal.Address Action -> AppModel -> Html
view address model =
  let
    _ =
      Debug.log "model" model
  in
    div
      []
      [ page address model ]


page : Signal.Address Action -> AppModel -> Html
page address model =
  case model.routing.route of
    Routing.MealsRoute ->
      mealsPage address model

    Routing.MealEditRoute mealId ->
      mealEditPage address model mealId

    Routing.NotFoundRoute ->
      notFoundView


mealsPage : Signal.Address Action -> AppModel -> Html
mealsPage address model =
  let
    viewModel =
      { meals = model.meals }
  in
    Meals.List.view (Signal.forwardTo address MealsAction) viewModel


mealEditPage : Signal.Address Action -> AppModel -> MealId -> Html
mealEditPage address model mealId =
  let
    maybeMeal =
      model.meals
        |> List.filter (\meal -> meal.id == mealId)
        |> List.head
  in
    case maybeMeal of
      Just meal ->
        let
          viewModel =
            { meal = meal }
        in
          Meals.Edit.view (Signal.forwardTo address MealsAction) viewModel

      Nothing ->
        notFoundView


notFoundView : Html
notFoundView =
  div
    []
    [ text "Not found"
    ]
