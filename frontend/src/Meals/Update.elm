module Meals.Update (..) where

import Effects exposing (Effects)
import Task
import Meals.Models exposing (..)
import Ingredients.Models exposing (Ingredient)
import Meals.Actions exposing (..)
import Meals.Effects exposing (..)
import Hop.Navigate exposing (navigateTo)


type alias UpdateModel =
  { meals : List Meal
  , currentMeal : Maybe Meal
  , ingredients : List Ingredient
  , ingredientSearchTerm : Maybe String
  , errorAddress : Signal.Address String
  , deleteConfirmationAddress : Signal.Address ( MealId, String )
  }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    CreateMeal ->
      ( model, create new )

    EditMeal mealId ->
      let
        path =
          "/meals/" ++ (toString mealId) ++ "/edit"
      in
        ( model, Effects.map HopAction (navigateTo path) )

    ListMeals ->
      let
        path =
          "/meals/"
      in
        ( model, Effects.map HopAction (navigateTo path) )

    ShowMeal mealId ->
      let
        path =
          "/meals/" ++ (toString mealId)
      in
        ( model, Effects.map HopAction (navigateTo path) )

    FetchAllDone result ->
      case result of
        Ok meals ->
          ( { model | meals = meals }, Effects.none )

        Err error ->
          let
            errorMsg =
              toString error

            fx =
              Signal.send model.errorAddress errorMsg
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, fx )

    FetchOneDone result ->
      case result of
        Ok meal ->
          ( { model | currentMeal = Just meal }, Effects.none )

        Err error ->
          let
            errorMsg =
              toString error

            fx =
              Signal.send model.errorAddress errorMsg
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, fx )

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
            ( { model | meals = updatedMeals }, fx )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.errorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, fx )

    DeleteMealIntent meal ->
      let
        msg =
          "Are you sure you want to delete " ++ meal.name ++ "?"

        fx =
          Signal.send model.deleteConfirmationAddress ( meal.id, msg )
            |> Effects.task
            |> Effects.map TaskDone
      in
        ( model, fx )

    DeleteMeal mealId ->
      ( model, delete mealId )

    DeleteMealDone mealId result ->
      case result of
        Ok _ ->
          let
            notDeleted meal =
              meal.id /= mealId

            updatedMeals =
              List.filter notDeleted model.meals
          in
            ( { model | meals = updatedMeals }, Effects.none )

        Err error ->
          let
            message =
              toString error

            fx =
              Signal.send model.errorAddress message
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, fx )

    ChangeIngredientAmount mealId ingredientId change ->
      let
        updateIngredientFx meal =
          let
            updateIngredient ingredientId change ingredient =
              if ingredient.ingredient.id == ingredientId then
                { ingredient | amount = ingredient.amount + change }
              else
                ingredient

            updatedIngredients =
              List.map (updateIngredient ingredientId change) meal.ingredients

            updatedMeal =
              { meal | ingredients = updatedIngredients }
          in
            save updatedMeal

        fx meal =
          case meal of
            Just meal ->
              if meal.id /= mealId then
                Effects.none
              else
                updateIngredientFx meal

            Nothing ->
              Effects.none
      in
        ( model, fx model.currentMeal )

    ChangeName mealId newName ->
      let
        updateNameFx meal =
          save { meal | name = newName }

        fx =
          case model.currentMeal of
            Just meal ->
              if meal.id /= mealId then
                Effects.none
              else
                updateNameFx meal

            Nothing ->
              Effects.none
      in
        ( model, fx )

    SaveDone result ->
      case result of
        Ok savedMeal ->
          let
            updateMeal meal =
              if meal.id == savedMeal.id then
                savedMeal
              else
                meal

            updatedMeals =
              List.map updateMeal model.meals
          in
            ( { model | meals = updatedMeals, currentMeal = Just savedMeal }, Effects.none )

        Err error ->
          let
            msg =
              toString error

            fx =
              Signal.send model.errorAddress msg
                |> Effects.task
                |> Effects.map TaskDone
          in
            ( model, fx )

    SearchIngredient term ->
      ( { model | ingredientSearchTerm = Just term }, Effects.none )

    TaskDone () ->
      ( model, Effects.none )

    HopAction _ ->
      ( model, Effects.none )

    NoOp ->
      ( model, Effects.none )
