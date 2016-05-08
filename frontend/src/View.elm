module View (..) where

import Models exposing (..)
import Actions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import String
import Routing
import Meals.List
import Meals.Edit
import Meals.Models exposing (MealId)


view : Signal.Address Action -> AppState -> Html
view address model =
  let
    _ =
      Debug.log "view" model
  in
    div
      []
      [ flash address model
      , page address model
      ]


flash : Signal.Address Action -> AppState -> Html
flash address model =
  if String.isEmpty model.errorMessage then
    span [] []
  else
    div
      [ class "bold center p2 mb2 white bg-red rounded" ]
      [ p [] [ text model.errorMessage ] ]


page : Signal.Address Action -> AppState -> Html
page address model =
  case model.routing.route of
    Routing.MealsRoute ->
      mealsPage address model

    Routing.MealEditRoute mealId ->
      mealEditPage address model mealId

    Routing.MealShowRoute mealId ->
      mealEditPage address model mealId

    Routing.NotFoundRoute ->
      notFoundView


mealsPage : Signal.Address Action -> AppState -> Html
mealsPage address model =
  let
    viewModel =
      { meals = model.meals.meals }
  in
    Meals.List.view (Signal.forwardTo address MealsAction) viewModel


mealEditPage : Signal.Address Action -> AppState -> MealId -> Html
mealEditPage address model mealId =
  let
    meal =
      case model.meals.currentMeal of
        Just meal ->
          meal

        Nothing ->
          Meals.Models.newMeal

    searchTerm =
      case model.ingredients.searchTerm of
        Just term ->
          term

        Nothing ->
          ""

    viewModel =
      { meal = meal, ingredientSearchTerm = searchTerm }
  in
    Meals.Edit.view (Signal.forwardTo address MealsAction) viewModel


notFoundView : Html
notFoundView =
  div
    []
    [ text "Not found"
    ]
