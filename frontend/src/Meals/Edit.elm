module Meals.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Meals.Models exposing (..)
import Ingredients.Models exposing (..)
import Meals.Actions exposing (..)


type alias ViewModel =
  { meal : Meal
  }


view : Signal.Address Action -> ViewModel -> Html
view address model =
  div
    []
    [ nav address model
    , form address model
    ]


nav : Signal.Address Action -> ViewModel -> Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    []


form : Signal.Address Action -> ViewModel -> Html
form address model =
  div
    [ class "m3" ]
    ([ h1 [] [ text model.meal.name ]
     , formName address model
     ]
      ++ formIngredients address model
    )


formName : Signal.Address Action -> ViewModel -> Html
formName address model =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text "Name" ]
    , div
        [ class "col col-7" ]
        [ inputName address model
        ]
    ]


inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input
    [ class "field-light"
    , value model.meal.name
    ]
    []


formIngredients : Signal.Address Action -> ViewModel -> List Html
formIngredients address model =
  List.map
    (formIngredient address)
    model.meal.ingredients


formIngredient : Signal.Address Action -> MealIngredient -> Html
formIngredient address ingredient =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text ingredient.ingredient.name ]
    , div
        [ class "col col-7" ]
        [ span [ class "h2 bold" ] [ text (toString ingredient.amount) ]
        , btnAmountDecrease address ingredient
        , btnAmountIncrease address ingredient
        ]
    ]


btnAmountIncrease : Signal.Address Action -> MealIngredient -> Html
btnAmountIncrease address ingredient =
  a
    [ class "btn ml1 h1" ]
    [ i [ class "fa fa-plus-circle" ] [] ]


btnAmountDecrease : Signal.Address Action -> MealIngredient -> Html
btnAmountDecrease address ingredient =
  a
    [ class "btn ml1 h1" ]
    [ i [ class "fa fa-minus-circle" ] [] ]
