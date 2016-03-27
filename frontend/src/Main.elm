module Main (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Models exposing (..)
import Actions exposing (..)
import Update exposing (..)
import View exposing (..)
import Routing


routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction Routing.signal


init : ( AppModel, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal ]
    , update = update
    , view = view
    }


main : Signal Html
main =
  app.html


port runner : Signal (Task Never ())
port runner =
  app.tasks


port routeRunTask : Task () ()
port routeRunTask =
  Routing.run
