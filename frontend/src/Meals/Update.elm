module Meals.Update (..) where

import Effects exposing (Effects)
import Meals.Models exposing (..)
import Meals.Actions exposing (..)
import Hop.Navigate exposing (navigateTo)


type alias UpdateModel =
  { meals : List Meal
  , currentMeal : Maybe Meal
  }


update : Action -> UpdateModel -> ( List Meal, Maybe Meal, Effects Action )
update action model =
  case action of
    EditMeal mealId ->
      let
        path =
          "/meals/" ++ (toString mealId) ++ "/edit"
      in
        ( model.meals, model.currentMeal, Effects.map HopAction (navigateTo path) )

    ListMeals ->
      let
        path =
          "/meals/"
      in
        ( model.meals, model.currentMeal, Effects.map HopAction (navigateTo path) )

    ShowMeal mealId ->
      let
        path =
          "/meals/" ++ (toString mealId)
      in
        ( model.meals, model.currentMeal, Effects.map HopAction (navigateTo path) )

    FetchAllDone result ->
      case result of
        Ok meals ->
          ( meals, model.currentMeal, Effects.none )

        Err errors ->
          ( model.meals, model.currentMeal, Effects.none )

    FetchOneDone result ->
      case result of
        Ok meal ->
          ( model.meals, Just meal, Effects.none )

        Err errors ->
          ( model.meals, Nothing, Effects.none )

    HopAction _ ->
      ( model.meals, model.currentMeal, Effects.none )

    NoOp ->
      ( model.meals, model.currentMeal, Effects.none )
