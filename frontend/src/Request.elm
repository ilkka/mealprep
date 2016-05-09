module Request (..) where

import Http.Extra as HttpExtra exposing (..)
import Time
import Task exposing (Task)
import Effects exposing (Effects)
import Json.Decode as Decode
import Json.Encode as Encode


responseDecoder : Decode.Decoder a -> Decode.Decoder a
responseDecoder innerDecoder =
  Decode.at [ "data" ] innerDecoder


responseEncoder : String -> Encode.Value -> Encode.Value
responseEncoder key innerEncoder =
  [ ( key, innerEncoder ) ] |> Encode.object


withOptions : RequestBuilder -> RequestBuilder
withOptions =
  (withHeader "Content-Type" "application/json") << (withTimeout (10 * Time.second))


toEffects : (Result a b -> c) -> Task a b -> Effects c
toEffects action =
  Task.toResult >> Task.map action >> Effects.task


sendRequest : Decode.Decoder a -> RequestBuilder -> Task (Error String) (Response a)
sendRequest decoder =
  send (jsonReader (responseDecoder decoder)) stringReader


get : String -> Decode.Decoder a -> (Result (Error String) a -> b) -> Effects b
get url decoder action =
  HttpExtra.get url
    |> withOptions
    |> sendRequest decoder
    |> Task.map (\response -> response.data)
    |> toEffects action


post : String -> Encode.Value -> Decode.Decoder a -> (Result (Error String) a -> b) -> Effects b
post url body decoder action =
  HttpExtra.post url
    |> withOptions
    |> withJsonBody body
    |> sendRequest decoder
    |> Task.map (\response -> response.data)
    |> toEffects action
