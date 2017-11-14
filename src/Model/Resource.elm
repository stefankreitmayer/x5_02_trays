module Model.Resource exposing (..)

import Dict exposing (Dict)

type alias Resource =
  { title : String
  , url : String
  , kind : String
  , date : String
  , annotations : Dict String String }
