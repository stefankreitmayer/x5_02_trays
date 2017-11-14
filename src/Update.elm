module Update exposing (..)


import Model exposing (..)
import Model.Ui exposing (..)
import Msg exposing (..)

import Debug exposing (log)


update : Msg -> Model -> (Model, Cmd Msg)
update action ({resources} as model) =
  case action of
    Noop ->
      (model, Cmd.none)
