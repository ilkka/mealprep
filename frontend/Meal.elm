module Meal (..) where

import Html exposing (Html)
import Ingredient


-- Model


type alias MealIngredient =
  { ingredient : Ingredient.Model
  , amount : Int
  }


type alias Model =
  { name : String
  , ingredients : List MealIngredient
  }


initialModel : Model
initialModel =
  { name = "Nutritious meal"
  , ingredients = []
  }


type Action
  = NoOp



-- View


view : Signal.Address action -> Model -> Html
view a m =
  Html.p [] [ Html.text "morjestaa" ]



-- Update


update : Action -> Model -> Model
update a m =
  m
