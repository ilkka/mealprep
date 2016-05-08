module Meals.Models (..) where

import Ingredients.Models


type alias MealId =
  Int


type alias MealIngredient =
  { ingredient : Ingredients.Models.Ingredient
  , amount : Float
  }


type alias Meal =
  { id : MealId
  , name : String
  , ingredients : List MealIngredient
  }


type alias State =
  { meals : List Meal
  , currentMeal : Maybe Meal
  }


newMeal : Meal
newMeal =
  { id = 0
  , name = "New meal"
  , ingredients = []
  }


initialState : State
initialState =
  { meals = []
  , currentMeal = Nothing
  }
