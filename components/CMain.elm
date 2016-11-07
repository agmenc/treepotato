module CMain exposing (..)

import CPage exposing (Model, view, update)
import Html.App as Html
import Platform.Cmd exposing (Cmd)


main : Program Never
main =
    Html.program
        { init = ( CPage.initialModel, Cmd.none )
        , update = CPage.update
        , view = CPage.view
        , subscriptions = CPage.subscriptions
        }
