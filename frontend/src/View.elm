module View (..) where

import Models exposing (..)
import Actions exposing (..)
import Html exposing (..)


view : Signal.Address Action -> AppModel -> Html
view address model =
  div
    []
    [ text "Hello" ]
