module Ingredients.Models (..) where


type alias IngredientId =
  Int


type alias Ingredient =
  { id : IngredientId
  , name : String
  }


type alias State =
  { ingredients : List Ingredient
  , searchTerm : Maybe String
  }


new : Ingredient
new =
  { id = 0
  , name = "Ingredient"
  }


initialState : State
initialState =
  { ingredients = []
  , searchTerm = Nothing
  }
