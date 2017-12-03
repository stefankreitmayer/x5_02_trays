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

    ShowDetails resource ->
      ({ model | expandedResourcesByUrl = resource.url :: model.expandedResourcesByUrl}, Cmd.none)

    HideDetails resource ->
      ({ model | expandedResourcesByUrl = model.expandedResourcesByUrl |> List.filter (\url -> not (url == resource.url))}, Cmd.none)
