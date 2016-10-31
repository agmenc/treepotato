module Page exposing (..)

import Messages exposing (..)
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


type alias Component model a =
    { initialModel : model
    , update : Msg a -> Model -> ( Model, Cmd (Msg a) )
    , view : Model -> Html (Msg a)
    }



-- MODEL


type alias Model =
    { searchModel : String
    , treeModel : Tree.Node
    }


initialModel : Model
initialModel =
    Model "" Tree.initialModel



-- UPDATE


update : Msg a -> Model -> ( Model, Cmd (Msg a) )
update action oldModel =
    ( { oldModel
        | treeModel = oldModel.treeModel
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Html (Msg a)
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


spacer : Html (Msg a)
spacer =
    fullRow
        [ div
            [ style [ ( "margin-top", "5px" ) ] ]
            []
        ]


pageStyle : Attribute (Msg a)
pageStyle =
    style
        [ ( "margin-left", "25px" )
        , ( "margin-right", "25px" )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub (Msg a)
subscriptions model =
    Sub.none
