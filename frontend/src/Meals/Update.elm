module Meals.Update (..) where

import Effects exposing (Effects)
import Task
import Meals.Models exposing (..)
import Meals.Actions exposing (..)
import Meals.Effects exposing (..)
import Hop.Navigate exposing (navigateTo)


type alias UpdateModel =
  { meals : List Meal
  , currentMeal : Maybe Meal
  , errorAddress : Signal.Address String
  , deleteConfirmationAddress : Signal.Address ( MealId, String )
  }


update : Action -> UpdateModel -> ( List Meal, Maybe Meal, Effects Action )
update action model =
  case action of
    CreateMeal ->
      ( model.meals, model.currentMeal, create new )

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

        Err error ->
          let
            errorMsg =
              toString error

            fx =
              Signal.send model.errorAddress errorMsg
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.meals, model.currentMeal, fx )

    FetchOneDone result ->
      case result of
        Ok meal ->
          ( model.meals, Just meal, Effects.none )

        Err error ->
          let
            errorMsg =
              toString error

            fx =
              Signal.send model.errorAddress errorMsg
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.meals, model.currentMeal, fx )

    CreateMealDone result ->
      case result of
        Ok meal ->
          let
            updatedMeals =
              meal :: model.meals

            fx =
              Task.succeed (EditMeal meal.id)
                |> Effects.task
          in
            ( updatedMeals, model.currentMeal, fx )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.errorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model.meals, model.currentMeal, fx )

    DeleteMealIntent meal ->
      let
        msg =
          "Are you sure you want to delete " ++ meal.name ++ "?"

        fx =
          Signal.send model.deleteConfirmationAddress ( meal.id, msg )
            |> Effects.task
            |> Effects.map TaskDone
      in
        ( model.meals, model.currentMeal, fx )

    DeleteMeal mealId ->
      ( model.meals, model.currentMeal, Effects.none )

    DeleteMealDone mealId result ->
      ( model.meals, model.currentMeal, Effects.none )

    TaskDone () ->
      ( model.meals, model.currentMeal, Effects.none )

    HopAction _ ->
      ( model.meals, model.currentMeal, Effects.none )

    NoOp ->
      ( model.meals, model.currentMeal, Effects.none )
