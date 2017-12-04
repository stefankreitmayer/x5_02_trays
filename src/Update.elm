module Update exposing (..)

import Set
import Dict
import Debug exposing (log)


import Model exposing (..)
import Model.Ui exposing (..)
import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action oldModel =
  let
      model =
        case action of
          ToggleItemDropmenu _ ->
            oldModel
          _ ->
            closeDropmenu oldModel
  in
      case action of
        ChangeSearchString _ ->
          (model, Cmd.none)

        AddResourceToProject resource ->
          ({ model | projectResources = resource :: model.projectResources }, Cmd.none)

        ShowDetails resource ->
          ({ model | expandedSearchResults = resource.url :: model.expandedSearchResults}, Cmd.none)

        HideDetails resource ->
          ({ model | expandedSearchResults = model.expandedSearchResults |> List.filter (\url -> not (url == resource.url))}, Cmd.none)

        ToggleItemDropmenu resource ->
          let
              newState = if model.itemDropmenu == Just resource then Nothing else Just resource
          in
              ({ model | itemDropmenu = newState }, Cmd.none)

        RemoveResourceFromProject resource ->
          ({ model | projectResources = model.projectResources |> List.filter (\res -> not (res == resource)) }, Cmd.none)

        ToggleItemOptional resource checked ->
          let
              optionalItems =
                model.optionalItems |> (if checked then Set.insert else Set.remove) resource.url
          in
              ({ model | optionalItems = optionalItems }, Cmd.none)

        ChangeAnnotation resource name value ->
          ({ model | annotations = model.annotations |> Dict.insert (resource.url, name) value }, Cmd.none)



closeDropmenu : Model -> Model
closeDropmenu model =
  { model | itemDropmenu = Nothing }
