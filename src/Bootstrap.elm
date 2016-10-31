module Bootstrap exposing (..)

import List
import String
import Html exposing (..)
import Html.Attributes exposing (..)

container : List (Html msg) -> Html msg
container rows = div [ class "container-fluid" ] rows

row : List (Html msg) -> Html msg
row cells = div [ class "row" ] cells

col : Int -> List (Html msg) -> Html msg
col n contents = div [ class (reactiveColumns n) ] contents

reactiveColumns : Int -> String
reactiveColumns number =
  let
    prefixes = [ "col-xs-", "col-sm-", "col-md-", "col-lg-" ]
    columnClasses = List.map (\p -> p ++ toString(number)) prefixes
  in
    String.join " " columnClasses

fullRow : List (Html msg) -> Html msg
fullRow cells = row [ col 12 cells ]

