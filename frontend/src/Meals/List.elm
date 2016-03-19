module Meals.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Meals.Actions exposing (..)
import Meals.Models exposing (Meal)


type alias ViewModel =
  { meals : List Meal }


view : Signal.Address Action -> ViewModel -> Html
view address model =
  div
    []
    [ nav address model
    , list address model
    ]


nav : Signal.Address Action -> ViewModel -> Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Meals" ] ]


list : Signal.Address Action -> ViewModel -> Html
list address model =
  div
    []
    [ table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Id" ]
                , th [] [ text "Name" ]
                ]
            ]
        , tbody [] (List.map (mealRow address model) model.meals)
        ]
    ]


mealRow : Signal.Address Action -> ViewModel -> Meal -> Html
mealRow address model meal =
  tr
    []
    [ td [] [ text (toString meal.id) ]
    , td [] [ text meal.name ]
    ]
