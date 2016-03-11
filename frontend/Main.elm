module Main (..) where

import Html exposing (Html)
import Meal
import StartApp.Simple exposing (start)


-- Model


type alias Model =
  { meal : Meal.Model
  }


initialModel : Model
initialModel =
  { meal = Meal.initialModel
  }


type Action
  = NoOp
  | MealAction Meal.Action



-- View


view : Signal.Address Action -> Model -> Html
view address model =
  Html.div [] [ Meal.view (Signal.forwardTo address MealAction) model.meal ]



-- Update


update : Action -> Model -> Model
update action model =
  model



-- Main


main : Signal Html
main =
  start
    { model = initialModel
    , update = update
    , view = view
    }
