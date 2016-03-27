module Routing (..) where

import Task exposing (Task)
import Effects exposing (Effects, Never)
import Hop
import Hop.Types exposing (Location, PathMatcher, Router, newLocation)
import Hop.Navigate exposing (navigateTo)
import Hop.Matchers exposing (match1, match2, match3, int)
import Meals.Models exposing (MealId)


-- Routes


type Route
  = MealsRoute
  | MealEditRoute MealId
  | NotFoundRoute



{-
Actions.

NavigateTo is the action that starts the browser location change.

The way Hop tells us that the browser location needs to change is a task, and
of course that needs to be stuffed into a port so that it is executed. We wrap that
into a HopAction.

Finally ApplyRoute signals a finished location change (I think lol)
-}


type Action
  = NavigateTo String
  | HopAction ()
  | ApplyRoute ( Route, Location )



-- Model for routing purposes


type alias Model =
  { location : Location
  , route : Route
  }


initialModel : Model
initialModel =
  { location = newLocation
  , route = MealsRoute
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NavigateTo path ->
      ( model, Effects.map HopAction (navigateTo path) )

    ApplyRoute ( route, location ) ->
      ( { model | route = route, location = location }, Effects.none )

    HopAction () ->
      ( model, Effects.none )



-- Route matchers match path to our Routes way up ^^ there


indexMatcher : PathMatcher Route
indexMatcher =
  match1 MealsRoute "/"


mealsMatcher : PathMatcher Route
mealsMatcher =
  match1 MealsRoute "/meals"


mealEditMatcher : PathMatcher Route
mealEditMatcher =
  match3 MealEditRoute "/meals/" int "/edit"


matchers : List (PathMatcher Route)
matchers =
  [ indexMatcher
  , mealsMatcher
  , mealEditMatcher
  ]



-- Create the Hop router


router : Router Route
router =
  Hop.new
    { matchers = matchers
    , notFound = NotFoundRoute
    }



-- This task bootstraps routing


run : Task () ()
run =
  router.run



-- Map signal from router to Action that we use to power the app


signal : Signal Action
signal =
  Signal.map ApplyRoute router.signal
