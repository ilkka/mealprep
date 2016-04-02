module Meals.Update (..) where

import Effects exposing (Effects)
import Meals.Models exposing (..)
import Meals.Actions exposing (..)
import Hop.Navigate exposing (navigateTo)


type alias UpdateModel =
  { meals : List Meal }


update : Action -> UpdateModel -> ( List Meal, Effects Action )
update action model =
  case action of
    EditMeal mealId ->
      let
        path =
          "/meals/" ++ (toString mealId) ++ "/edit"
      in
        ( model.meals, Effects.map HopAction (navigateTo path) )

    ListMeals ->
      let
        path =
          "/meals/"
      in
        ( model.meals, Effects.map HopAction (navigateTo path) )

    FetchAllDone result ->
      case result of
        Ok meals ->
          ( meals, Effects.none )

        Err errors ->
          ( model.meals, Effects.none )

    HopAction _ ->
      ( model.meals, Effects.none )

    NoOp ->
      ( model.meals, Effects.none )
