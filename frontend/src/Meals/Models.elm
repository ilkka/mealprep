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


new : Meal
new =
  { id = 0
  , name = "Nutritious meal"
  , ingredients = []
  }
