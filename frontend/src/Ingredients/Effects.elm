module Ingredients.Effects (..) where

import Json.Decode as Decode exposing ((:=))
import Ingredients.Models exposing (IngredientId, Ingredient)


-- TODO: fetch
-- decoders (TODO: replace with streaming version)


collectionDecoder : Decode.Decoder (List Ingredient)
collectionDecoder =
  Decode.list ingredientDecoder


ingredientDecoder : Decode.Decoder Ingredient
ingredientDecoder =
  Decode.object2
    Ingredient
    ("id" := Decode.int)
    ("name" := Decode.string)
