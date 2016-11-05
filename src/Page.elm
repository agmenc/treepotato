module Page exposing (..)

import Bootstrap exposing (..)
import Tree exposing (..)
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
    , view : Model -> Html PageMsg
    }



-- MODEL


type PageMsg
    = NoAction
    | TreeMsg
    | FilterBy String


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


view : Model -> Html PageMsg
view model =
    div
        [ pageStyle ]
        [ container
            [ text ("TreePotato")
            , spacer
            , row [ SearchTerms.view FilterBy ]
            , spacer
            , row [ Tree.view model.treeModel ]
            , spacer
            , text ("Results")
            ]
        ]


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
