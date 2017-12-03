module Model exposing (..)

import Model.Ui exposing (..)
import Model.Resource exposing (..)
import Model.FakeData

import Element.Input as Input

type alias Model =
  { ui : Ui
  , searchResults : List Resource
  , projectResources : List Resource
  , errorMsg : Maybe String }


initialModel : Model
initialModel =
  { ui = initialUi
  , searchResults = Model.FakeData.exampleResources
  , projectResources = []
  , errorMsg = Nothing }
