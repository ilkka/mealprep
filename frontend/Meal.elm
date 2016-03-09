module Meal where

import Html exposing (..)
import Ingredient


-- MODEL

type alias MealIngredient = {
    ingredient : Ingredient,
    amount : Int
}

type alias Model = {
    name : String,
    ingredients : List MealIngredient
}

init : Model
init =