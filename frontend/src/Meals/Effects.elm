module Meals.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
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


create : Meal -> Effects Action
create meal =
  let
    body =
      mealEncoder meal
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = createUrl
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson mealDecoder
      |> Task.toResult
      |> Task.map CreateMealDone
      |> Effects.task


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/api/v1/meals"


fetchOneUri : Int -> String
fetchOneUri id =
  "http://localhost:4000/api/v1/meals/" ++ (toString id)


createUrl : String
createUrl =
  "http://localhost:4000/api/v1/meals"



-- decoders (TODO: replace this with the streaming stuff)


responseDecoder : Decode.Decoder a -> Decode.Decoder a
responseDecoder innerDecoder =
  Decode.at [ "data" ] innerDecoder


collectionDecoder : Decode.Decoder (List Meal)
collectionDecoder =
  Decode.list mealSummaryDecoder


ingredientCollectionEncoder : List MealIngredient -> Encode.Value
ingredientCollectionEncoder ingredients =
  Encode.list (List.map ingredientMemberEncoder ingredients)


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


mealEncoder : Meal -> Encode.Value
mealEncoder meal =
  let
    list =
      [ ( "id", Encode.int meal.id )
      , ( "name", Encode.string meal.name )
      , ( "ingredients", ingredientCollectionEncoder meal.ingredients )
      ]
  in
    list
      |> Encode.object


mealDecoder : Decode.Decoder Meal
mealDecoder =
  Decode.object3
    Meal
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("ingredients" := ingredientCollectionDecoder)


ingredientMemberEncoder : MealIngredient -> Encode.Value
ingredientMemberEncoder ingredient =
  let
    list =
      [ ( "ingredient", Ingredients.Effects.ingredientEncoder ingredient.ingredient )
      , ( "amount", Encode.float ingredient.amount )
      ]
  in
    list
      |> Encode.object


ingredientMemberDecoder : Decode.Decoder MealIngredient
ingredientMemberDecoder =
  Decode.object2
    MealIngredient
    ("ingredient" := Ingredients.Effects.ingredientDecoder)
    ("amount" := Decode.float)
