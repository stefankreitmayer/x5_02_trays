module Model.Resource exposing (..)

import Dict exposing (Dict)

type alias Resource =
  { title : String
  , url : String
  , coverImageStub : String
  , kind : String
  , date : String
  , annotations : Dict String String }


workloadInHours model resource =
  model.annotations
  |> Dict.get (resource.url, "Workload (hours)")
  |> Maybe.withDefault "0.5"
  |> String.toFloat
  |> Result.withDefault 0.5
