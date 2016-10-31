module Main exposing (..)

import Page exposing (Model, view, update)

import Html.App as Html
import Platform.Cmd exposing (Cmd)

main: Program Never
main =
  Html.program
    { init = (Page.initialModel, Cmd.none)
    , update = Page.update
    , view = Page.view
    , subscriptions = Page.subscriptions
    }
