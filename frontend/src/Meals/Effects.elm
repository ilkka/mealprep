module Meals.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task exposing (Task, andThen)
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
  Http.get (responseDecoder mealDecoder) (fetchOneUrl id)
    |> Task.toResult
    |> Task.map FetchOneDone
    |> Effects.task


create : Meal -> Effects Action
create meal =
  let
    body =
      responseEncoder "meal" (mealEncoder meal)
        |> Encode.encode 0
        |> Http.string

    request =
      jsonRequest "POST" createUrl body
  in
    Http.send Http.defaultSettings request
      |> Http.fromJson (responseDecoder mealDecoder)
      |> Task.toResult
      |> Task.map CreateMealDone
      |> Effects.task


delete : MealId -> Effects Action
delete mealId =
  deleteTask mealId
    |> Task.toResult
    |> Task.map (DeleteMealDone mealId)
    |> Effects.task


deleteTask : MealId -> Task Http.Error ()
deleteTask mealId =
  let
    request =
      jsonRequest "DELETE" (deleteUrl mealId) Http.empty
  in
    Http.send Http.defaultSettings request
      `andThen` (\_ -> Task.succeed ())
      |> Task.mapError (\_ -> Http.NetworkError)


save : Meal -> Effects Action
save meal =
  saveTask meal
    |> Task.toResult
    |> Task.map SaveDone
    |> Effects.task


saveTask : Meal -> Task Http.Error Meal
saveTask meal =
  let
    body =
      responseEncoder "meal" (mealEncoder meal)
        |> Encode.encode 0
        |> Http.string

    request =
      jsonRequest "PATCH" (saveUrl meal.id) body
  in
    Http.send Http.defaultSettings request
      |> Http.fromJson (responseDecoder mealDecoder)


jsonRequest : String -> String -> Http.Body -> Http.Request
jsonRequest verb url body =
  { verb = verb
  , headers = [ ( "Content-Type", "application/json" ) ]
  , url = url
  , body = body
  }


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/api/v1/meals"


fetchOneUrl : Int -> String
fetchOneUrl id =
  "http://localhost:4000/api/v1/meals/" ++ (toString id)


createUrl : String
createUrl =
  "http://localhost:4000/api/v1/meals"


deleteUrl : MealId -> String
deleteUrl id =
  "http://localhost:4000/api/v1/meals/" ++ (toString id)


saveUrl : MealId -> String
saveUrl id =
  "http://localhost:4000/api/v1/meals/" ++ (toString id)



-- decoders (TODO: replace this with the streaming stuff)


responseDecoder : Decode.Decoder a -> Decode.Decoder a
responseDecoder innerDecoder =
  Decode.at [ "data" ] innerDecoder


responseEncoder : String -> Encode.Value -> Encode.Value
responseEncoder key innerEncoder =
  [ ( key, innerEncoder ) ] |> Encode.object


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
