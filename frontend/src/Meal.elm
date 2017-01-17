module Meal exposing (Model, Msg, init, update, view)

import Html exposing (Html)


-- VIEW


view : Meal -> Html Msg
view meal =
    div []
        [ p [] [ text ("Details for " ++ meal.name) ] ]
