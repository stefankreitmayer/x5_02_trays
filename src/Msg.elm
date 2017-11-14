module Msg exposing (..)

import Model exposing (..)
import Model.Ui exposing (..)


type Msg
  = Noop


subscriptions : Model -> Sub Msg
subscriptions {ui} =
  [] |> Sub.batch
