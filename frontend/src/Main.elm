module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Navigation
import UrlParser exposing (Parser, (</>), oneOf, format, int)
import String


-- APP


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = subscriptions
        }



-- URL PARSERS


urlParser : Navigation.Parser (Result String Page)
urlParser =
    Navigation.makeParser hashParser


hashParser : Navigation.Location -> Result String Page
hashParser location =
    UrlParser.parse identity pageParser (String.dropLeft 1 location.hash)


type Page
    = Home
    | MealPage Int


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (UrlParser.s "home")
        , format MealPage (UrlParser.s "meal" </> int)
        ]


toHash : Page -> String
toHash page =
    case page of
        Home ->
            "#home"

        MealPage id ->
            "#meal/" ++ toString id



-- MODEL


type alias Model =
    { page : Page
    , meals : List Meal
    , meal : Maybe Meal
    }


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


initialMeals : List Meal
initialMeals =
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


init : Result String Page -> ( Model, Cmd Msg )
init result =
    urlUpdate result (Model Home initialMeals (List.head initialMeals))



-- UPDATE


type Msg
    = NoOp
    | ShowMeal Int


{-| Update based on messages. Cause URLs to change maybe.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ShowMeal id ->
            let
                mealPage =
                    MealPage id
            in
                ( { model | page = mealPage }, (Navigation.newUrl (toHash mealPage)) )


{-| When URL updates, change model.
-}
urlUpdate : Result String Page -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case Debug.log "result" result of
        Err _ ->
            ( model, Navigation.modifyUrl (toHash Home) )

        Ok ((MealPage id) as page) ->
            ( { model
                | page = page
                , meal = List.head (List.filter (\x -> x.id == id) initialMeals)
              }
            , Cmd.none
            )

        Ok Home ->
            ( { model | page = Home, meal = Nothing }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        content =
            case model.page of
                Home ->
                    [ mealsView model.meals ]

                MealPage id ->
                    [ mealDetailView model.meal ]
    in
        div [ class "flex" ]
            [ div [ class "flex-auto" ]
                content
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


mealDetailView : Maybe Meal -> Html Msg
mealDetailView meal =
    case meal of
        Just meal ->
            div []
                [ p [] [ text ("Details for " ++ meal.name) ] ]

        Nothing ->
            div [] [ p [] [ text "No meal selected" ] ]
