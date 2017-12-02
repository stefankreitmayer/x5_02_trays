module Msg exposing (..)

import Model exposing (..)
import Model.Ui exposing (..)


type Msg
  = ChangeSearchString String


subscriptions : Model -> Sub Msg
subscriptions {ui} =
  [] |> Sub.batch
