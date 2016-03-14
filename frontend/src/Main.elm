module Main (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Models exposing (..)
import Actions exposing (..)
import Update exposing (..)
import View exposing (..)


-- Start app


init : ( AppModel, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }


main : Signal Html
main =
  app.html


port runner : Signal (Task Never ())
port runner =
  app.tasks
