module Model exposing (..)

import Model.Ui exposing (..)
import Model.Resource exposing (..)
import Model.FakeData


type alias Model =
  { ui : Ui
  , resources : List Resource
  , errorMsg : Maybe String }


initialModel : Model
initialModel =
  { ui = initialUi
  , resources = Model.FakeData.hardcodedResources
  , errorMsg = Nothing }
