module Update exposing (..)


import Model exposing (..)
import Model.Ui exposing (..)
import Msg exposing (..)

import Debug exposing (log)


update : Msg -> Model -> (Model, Cmd Msg)
update action ({searchResults} as model) =
  case action of
    ChangeSearchString _ ->
      (model, Cmd.none)

    AddResourceToProject resource ->
      ({ model | projectResources = resource :: model.projectResources }, Cmd.none)
