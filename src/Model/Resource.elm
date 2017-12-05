module Model.Resource exposing (..)

import Set exposing (Set)
import Dict exposing (Dict)

type alias Resource =
  { title : String
  , url : String
  , coverImageStub : String
  , date : String
  , tags : Set String
  , features : Dict String String }


workloadInHours model resource =
  model.annotations
  |> Dict.get (resource.url, attrTextWorkload)
  |> Maybe.withDefault "0.5"
  |> String.toFloat
  |> Result.withDefault 0.5


attrTextWorkload =
  "Workload (hours)"
