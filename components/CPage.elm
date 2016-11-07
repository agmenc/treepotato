module CPage exposing (..)

import Bootstrap exposing (..)
import SearchTerms exposing (..)
import String
import Html.App as Html
import Html.Events exposing (onClick)
import Html exposing (Html, div, Attribute, br, text)
import Html.Attributes exposing (..)
import Keyboard exposing (KeyCode, downs)
import Platform.Cmd exposing (Cmd)
import Platform.Sub exposing (Sub, none)
import Task exposing (Task, andThen)
import Debug exposing (log)


-- MODULES


type alias Component model =
    { initialModel : model
    , update : PageMsg -> Model -> ( Model, Cmd PageMsg )
    , view :
        Model -> Html PageMsg
        -- Use noSubscriptions, or we actually have subscriptions and we use those
    , subscriptions : Model -> Sub PageMsg
    }


noSubscriptions : Model -> Sub PageMsg
noSubscriptions model =
    Sub.none



-- MODEL


type PageMsg
    = NoAction
    | DoX
    | DoY
    | SearchBy String


type alias Model =
    { doing : String
    , things : List String
    , searchBy : String
    }


initialModel : Model
initialModel =
    Model "" [ "Blue", "Fast", "Cow", "Four" ] ""



-- UPDATE


update : PageMsg -> Model -> ( Model, Cmd PageMsg )
update action oldModel =
    case action of
        DoX ->
            ( { oldModel | doing = "X" }, Cmd.none )

        _ ->
            ( oldModel, Cmd.none )



-- VIEW


view : Model -> Html PageMsg
view model =
    div
        [ pageStyle ]
        [ container
            [ spacer
            , listOfThings model.things
            , spacer
            , text ("Button Row")
            , spacer
            , text ("Current Actions")
            , spacer
            , text ("Search Box")
            , spacer
            , text ("Search Results")
            ]
        ]


listOfThings : List String -> Html PageMsg
listOfThings things =
    div
        []
        (List.map text things)


spacer : Html PageMsg
spacer =
    fullRow
        [ div
            [ style [ ( "margin-top", "5px" ) ] ]
            []
        ]


pageStyle : Attribute PageMsg
pageStyle =
    style
        [ ( "margin-left", "25px" )
        , ( "margin-right", "25px" )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub PageMsg
subscriptions model =
    Sub.none
