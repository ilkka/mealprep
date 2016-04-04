module Meals.Actions (..) where

import Meals.Models exposing (MealId, Meal)
import Http


type Action
  = NoOp
  | HopAction ()
  | ShowMeal MealId
  | EditMeal MealId
  | ListMeals
  | FetchAllDone (Result Http.Error (List Meal))
  | FetchOneDone (Result Http.Error Meal)
  | TaskDone ()
