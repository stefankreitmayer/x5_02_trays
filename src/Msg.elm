module Msg exposing (..)

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Resource exposing (..)


type Msg
  = ChangeSearchString String
  | AddResourceToProject Resource
  | ShowDetails Resource
  | HideDetails Resource
  | ToggleItemDropmenu Resource
  | RemoveResourceFromProject Resource
  | ToggleItemOptional Resource Bool


subscriptions : Model -> Sub Msg
subscriptions {ui} =
  [] |> Sub.batch
