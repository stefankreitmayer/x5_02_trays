module Model exposing (..)

import Set exposing (Set)
import Element.Input as Input

import Model.Ui exposing (..)
import Model.Resource exposing (..)
import Model.FakeData


type alias Model =
  { ui : Ui
  , searchResults : List Resource
  , projectResources : List Resource
  , expandedSearchResults : List String
  , itemDropmenu : Maybe Resource
  , optionalItems : Set String
  , errorMsg : Maybe String }


initialModel : Model
initialModel =
  { ui = initialUi
  , searchResults = Model.FakeData.exampleResources
  , projectResources = []
  , expandedSearchResults = []
  , itemDropmenu = Nothing
  , optionalItems = Set.empty
  , errorMsg = Nothing }


isItemOptional model resource =
  model.optionalItems |> Set.member resource.url
