module Meal (..) where

import Html exposing (..)
import Signal exposing (Address)
import Ingredient


-- MODEL


type alias MealIngredient =
  { ingredient : Ingredient.Model
  , amount : Int
  }


type alias Model =
  { name : String
  , ingredients : List MealIngredient
  }


init : Model
init =
  { name = "Nutritious meal"
  , ingredients = []
  }


type Action
  = Nothing


update : Action -> Model -> Model
update a m =
  m


view : Address action -> Model -> Html
view a m =
  p [] [ text "morjestaa" ]
