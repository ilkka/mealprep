module View (..) where

import Models exposing (..)
import Actions exposing (..)
import Html exposing (..)
import Meals.List


view : Signal.Address Action -> AppModel -> Html
view address model =
  div
    []
    [ page address model ]


page : Signal.Address Action -> AppModel -> Html
page address model =
  let
    viewModel =
      { meals = model.meals }
  in
    Meals.List.view (Signal.forwardTo address MealsAction) viewModel
