module Meals.Edit (..) where

import Html exposing (..)
import Html.Events exposing (on, onClick, targetValue)
import Html.Attributes exposing (class, value, href)
import Meals.Models exposing (..)
import Meals.Actions exposing (..)


type alias ViewModel =
  { meal : Meal
  , ingredientSearchTerm : String
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
    [ btnList address model ]


form : Signal.Address Action -> ViewModel -> Html
form address model =
  div
    [ class "m3" ]
    ([ h1 [] [ text model.meal.name ]
     , formName address model
     , formAddIngredient address model
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


formAddIngredient : Signal.Address Action -> ViewModel -> Html
formAddIngredient address model =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text "Add ingredient" ]
    , div [ class "col col-7" ] [ inputIngredient address model ]
    ]


inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input
    [ class "field-light"
    , value model.meal.name
    , on "change" targetValue (\str -> Signal.message address (ChangeName model.meal.id str))
    ]
    []


inputIngredient : Signal.Address Action -> ViewModel -> Html.Html
inputIngredient address model =
  input
    [ class "field-light"
    , value model.ingredientSearchTerm
    , on "input" targetValue (\str -> Signal.message address (SearchIngredient str))
    ]
    []


formIngredients : Signal.Address Action -> ViewModel -> List Html
formIngredients address model =
  List.map
    (formIngredient address model)
    model.meal.ingredients


formIngredient : Signal.Address Action -> ViewModel -> MealIngredient -> Html
formIngredient address model ingredient =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-5" ] [ text ingredient.ingredient.name ]
    , div
        [ class "col col-7" ]
        [ span [ class "h2 bold" ] [ text (toString ingredient.amount) ]
        , btnAmountDecrease address model ingredient
        , btnAmountIncrease address model ingredient
        ]
    ]


btnAmountIncrease : Signal.Address Action -> ViewModel -> MealIngredient -> Html
btnAmountIncrease address model ingredient =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-plus-circle"
        , onClick address (ChangeIngredientAmount model.meal.id ingredient.ingredient.id 1.0)
        ]
        []
    ]


btnAmountDecrease : Signal.Address Action -> ViewModel -> MealIngredient -> Html
btnAmountDecrease address model ingredient =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-minus-circle"
        , onClick address (ChangeIngredientAmount model.meal.id ingredient.ingredient.id -1.0)
        ]
        []
    ]


btnList : Signal.Address Action -> ViewModel -> Html
btnList address model =
  button
    [ class "btn regular"
    , onClick address ListMeals
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
