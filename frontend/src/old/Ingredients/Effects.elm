module Ingredients.Effects (..) where

import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Effects exposing (Effects)
import Ingredients.Models exposing (IngredientId, Ingredient)
import Request exposing (..)
import Ingredients.Actions exposing (..)


-- decoders (TODO: replace with streaming version)


fetchAll : Effects Action
fetchAll =
  Request.get fetchAllUrl collectionDecoder FetchAllDone



-- endpoints


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/api/v1/ingredients"



-- decoders & encoders


collectionDecoder : Decode.Decoder (List Ingredient)
collectionDecoder =
  Decode.list ingredientDecoder


ingredientDecoder : Decode.Decoder Ingredient
ingredientDecoder =
  Decode.object2
    Ingredient
    ("id" := Decode.int)
    ("name" := Decode.string)


ingredientEncoder : Ingredient -> Encode.Value
ingredientEncoder ingredient =
  let
    props =
      [ ( "id", Encode.int ingredient.id )
      , ( "name", Encode.string ingredient.name )
      ]
  in
    props
      |> Encode.object
