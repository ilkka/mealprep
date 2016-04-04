module Meals.List (..) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, href)
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
                , th [] [ text "" ]
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
    , td [] [ a [ href "#", onClick address (ShowMeal meal.id) ] [ text meal.name ] ]
    , td [] [ btnEdit address meal ]
    ]


btnEdit : Signal.Address Action -> Meal -> Html
btnEdit address meal =
  button
    [ class "btn regular"
    , onClick address (EditMeal meal.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
