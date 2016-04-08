module Main (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import StartApp
import Models
import Actions exposing (..)
import Update exposing (..)
import View exposing (..)
import Routing
import Mailboxes exposing (..)
import Meals.Effects


routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction Routing.signal


init : ( Models.AppModel, Effects Action )
init =
  let
    fxs =
      [ Effects.map MealsAction Meals.Effects.fetchAll ]

    fx =
      Effects.batch fxs
  in
    ( Models.initialModel, fx )


app : StartApp.App Models.AppModel
app =
  StartApp.start
    { init = init
    , inputs = [ routerSignal, actionsMailbox.signal ]
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


port askDeleteConfirmation : Signal ( Int, String )
port askDeleteConfirmation =
  deleteConfirmationMailbox.signal
