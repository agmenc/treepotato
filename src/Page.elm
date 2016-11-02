module Page exposing (..)

import Bootstrap exposing (..)
import Tree exposing (..)
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
    , view : Model -> Html PageMsg
    }



-- MODEL


type PageMsg
    = NoAction
    | TreeMsg


type alias Model =
    { searchModel : String
    , treeModel : Tree.Node
    }


initialModel : Model
initialModel =
    Model "" Tree.initialModel


type X
    = A
    | B
    | List String



-- UPDATE


update : PageMsg -> Model -> ( Model, Cmd PageMsg )
update action oldModel =
    case action of
        TreeMsg ->
            ( { oldModel | treeModel = oldModel.treeModel }, Cmd.none )

        _ ->
            ( oldModel, Cmd.none )



-- VIEW


view : Model -> Html whatever
view model =
    div
        [ pageStyle ]
        [ container
            [ text ("TreePotato")
            , spacer
            , text ("Typeahead")
            , spacer
            , Tree.view model.treeModel
            , spacer
            , text ("Results")
            ]
        ]


spacer : Html whatever
spacer =
    fullRow
        [ div
            [ style [ ( "margin-top", "5px" ) ] ]
            []
        ]


pageStyle : Attribute whatever
pageStyle =
    style
        [ ( "margin-left", "25px" )
        , ( "margin-right", "25px" )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub PageMsg
subscriptions model =
    Sub.none
