module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)


-- APP


main : Program Never
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { meals : List Meal }


type alias Meal =
    { id : Int
    , name : String
    , ingredients : List MealIngredient
    }


type alias MealIngredient =
    { amount : Float
    , ingredient : Ingredient
    }


type alias Ingredient =
    { id : Int
    , name : String
    , components : List IngredientComponent
    }


type alias IngredientComponent =
    { value : Float
    , component : Component
    }


type alias Component =
    { id : Int
    , name : String
    }


model : Model
model =
    { meals =
        [ { id = 1
          , name = "Sufuruoka"
          , ingredients =
                [ { amount = 1.0
                  , ingredient =
                        { id = 1
                        , name = "Litteä kana"
                        , components =
                            [ { value = 1.0
                              , component = { id = 1, name = "Mako" }
                              }
                            ]
                        }
                  }
                ]
          }
        ]
    }



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "flex" ]
        [ div [ class "flex-auto" ]
            [ mealsView model.meals ]
        , div [ class "col-4" ]
            [ p [] [ text "This will be the sidebar" ] ]
        ]


mealsView : List Meal -> Html Msg
mealsView meals =
    div []
        ([ h2 [] [ text "Meals" ] ]
            ++ List.map mealView meals
        )


mealView : Meal -> Html Msg
mealView meal =
    div []
        [ p [] [ text meal.name ] ]
