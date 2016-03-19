module Ingredients.Models (..) where


type alias IngredientId =
  Int


type alias Ingredient =
  { id : IngredientId
  , name : String
  }


new : Ingredient
new =
  { id = 0
  , name = "Ingredient"
  }
