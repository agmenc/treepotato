module SearchTerms exposing (..)

import Messages exposing (..)
import Bootstrap exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onInput)
import String exposing (..)


-- VIEW


view : (String -> a) -> Html a
view filterBy =
    fullRow
        [ input
            [ placeholder "Type in some filter words"
            , id "filter"
            , onInput filterBy
            , myStyle
            , autofocus True
            ]
            []
        , br [] []
        ]


myStyle : Attribute whatever
myStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "40px" )
        , ( "padding", "10px 0" )
        , ( "font-size", "2em" )
        , ( "text-align", "center" )
        ]
