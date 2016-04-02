module Meals.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task exposing (Task)
import Meals.Models exposing (MealId, Meal, MealIngredient)
import Meals.Actions exposing (..)
import Ingredients.Effects


fetchAll : Effects Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map FetchAllDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/api/v1/meals"



-- decoders (TODO: replace this with the streaming stuff)


collectionDecoder : Decode.Decoder (List Meal)
collectionDecoder =
  Decode.list mealDecoder


ingredientCollectionDecoder : Decode.Decoder (List MealIngredient)
ingredientCollectionDecoder =
  Decode.list ingredientMemberDecoder


mealDecoder : Decode.Decoder Meal
mealDecoder =
  Decode.object3
    Meal
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("ingredients" := ingredientCollectionDecoder)


ingredientMemberDecoder : Decode.Decoder MealIngredient
ingredientMemberDecoder =
  Decode.object2
    MealIngredient
    ("ingredient" := Ingredients.Effects.ingredientDecoder)
    ("amount" := Decode.int)
