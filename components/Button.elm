module Button exposing (..)

import Bootstrap exposing (..)
import SearchTerms exposing (..)
import String
import Html exposing (Html, div, Attribute, br, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Keyboard exposing (KeyCode, downs)
import Platform.Cmd exposing (Cmd)
import Platform.Sub exposing (Sub, none)
import Task exposing (Task, andThen)
import Debug exposing (log)


-- MODEL


type ButtonMsg
    = Inactive
    | Active


type alias Model =
    { name : String
    , active : bool
    }


initialModel : Model
initialModel =
    Model "A Button" False



-- UPDATE


update : ButtonMsg -> Model -> ( Model, Cmd ButtonMsg )
update action oldModel =
    case action of
        Active ->
            ( { oldModel | doing = "X" }, Cmd.none )

        _ ->
            ( oldModel, Cmd.none )



-- VIEW


view : Model -> Html ButtonMsg
view model =
    div
        []
        [ button
            [ class "btn btn-xs btn-primary"
            , onClick
                (if model.active then
                    Inactive
                 else
                    Active
                )
            ]
            [ text
                (if model.active then
                    String.toUpper model.name
                 else
                    model.name
                )
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub ButtonMsg
subscriptions model =
    Sub.none
