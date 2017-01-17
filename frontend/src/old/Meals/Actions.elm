module Meals.Actions (..) where

import Meals.Models exposing (MealId, Meal)
import Ingredients.Models exposing (IngredientId)
import Http.Extra as HttpExtra exposing (Error, Response)


type Action
  = NoOp
  | HopAction ()
  | ShowMeal MealId
  | EditMeal MealId
  | CreateMeal
  | CreateMealDone (Result (Error String) Meal)
  | ListMeals
  | FetchAllDone (Result (Error String) (List Meal))
  | FetchOneDone (Result (Error String) Meal)
  | DeleteMealIntent Meal
  | DeleteMeal MealId
  | DeleteMealDone MealId (Result (Error String) ())
  | ChangeIngredientAmount MealId IngredientId Float
  | ChangeName MealId String
  | SearchIngredient String
  | SaveDone (Result (Error String) Meal)
  | TaskDone ()
