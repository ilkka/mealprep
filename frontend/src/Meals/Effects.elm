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
  Http.get (responseDecoder collectionDecoder) fetchAllUrl
    |> Task.toResult
    |> Task.map FetchAllDone
    |> Effects.task


fetchOne : Int -> Effects Action
fetchOne id =
  Http.get (responseDecoder mealDecoder) (fetchOneUri id)
    |> Task.toResult
    |> Task.map FetchOneDone
    |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/api/v1/meals"


fetchOneUri : Int -> String
fetchOneUri id =
  "http://localhost:4000/api/v1/meals/" ++ (toString id)



-- decoders (TODO: replace this with the streaming stuff)


responseDecoder : Decode.Decoder a -> Decode.Decoder a
responseDecoder innerDecoder =
  Decode.at [ "data" ] innerDecoder


collectionDecoder : Decode.Decoder (List Meal)
collectionDecoder =
  Decode.list mealSummaryDecoder


ingredientCollectionDecoder : Decode.Decoder (List MealIngredient)
ingredientCollectionDecoder =
  Decode.list ingredientMemberDecoder


mealSummaryDecoder : Decode.Decoder Meal
mealSummaryDecoder =
  Decode.object3
    Meal
    ("id" := Decode.int)
    ("name" := Decode.string)
    (Decode.succeed [])


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
    ("amount" := Decode.float)
