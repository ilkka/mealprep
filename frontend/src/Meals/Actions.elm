module Meals.Actions (..) where

import Meals.Models exposing (MealId, Meal)
import Http


type Action
  = NoOp
  | HopAction ()
  | ShowMeal MealId
  | EditMeal MealId
  | CreateMeal
  | CreateMealDone (Result Http.Error Meal)
  | ListMeals
  | FetchAllDone (Result Http.Error (List Meal))
  | FetchOneDone (Result Http.Error Meal)
  | DeleteMealIntent Meal
  | DeleteMeal MealId
  | DeleteMealDone MealId (Result Http.Error ())
  | TaskDone ()
