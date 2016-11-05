module Tree exposing (..)

import Bootstrap exposing (..)
import Messages exposing (..)
import String
import Html.App as Html
import Html.Events exposing (onClick)
import Html exposing (Html, div, Attribute, br, text, ul, li)
import Html.Attributes exposing (..)
import Keyboard exposing (KeyCode, downs)
import Platform.Cmd exposing (Cmd)
import Platform.Sub exposing (Sub, none)
import Task exposing (Task, andThen)
import Debug exposing (log)


-- MODEL


type TreeMsg
    = NoAction


type Node
    = Leaf String
    | Parent String (List Node)


initialModel : Node
initialModel =
    Parent
        "root"
        [ Parent
            "Monkeys"
            [ Parent
                "Climb"
                [ Leaf "Trees", Leaf "Elephants" ]
            , Parent
                "Fling"
                [ Leaf "Poo" ]
            ]
        , Parent
            "Elephants"
            [ Parent
                "Trunk"
                [ Leaf "Eat", Leaf "Drink" ]
            , Leaf "Grey"
            ]
        ]



-- UPDATE


update : TreeMsg -> Node -> ( Node, Cmd TreeMsg )
update action oldModel =
    ( oldModel, Cmd.none )


cmdOf : TreeMsg -> Node -> Cmd TreeMsg
cmdOf action model =
    case action of
        _ ->
            Cmd.none



-- VIEW


view : Node -> Html whatever
view tree =
    case tree of
        Parent label children ->
            parentView children label

        Leaf label ->
            leafView label


parentView : List Node -> String -> Html whatever
parentView children label =
    div
        []
        [ text label
        , text " +"
        , ul [] (List.map (\kid -> li [] [ view kid ]) children)
        ]


leafView : String -> Html whatever
leafView label =
    div
        []
        [ text label
        , text " +"
        ]



-- SUBSCRIPTIONS


subscriptions : Node -> Sub TreeMsg
subscriptions model =
    Sub.none
