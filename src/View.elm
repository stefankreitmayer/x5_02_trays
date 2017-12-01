module View exposing (view)

import Html exposing (Html)
import Color exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)

import Style
import Style.Color as Color
import Style.Font as Font
import Style.Border as Border

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Resource exposing (..)

import Msg exposing (..)


type MyStyles
    = NoStyle
    | DebugStyle
    | HeaderStyle


stylesheet =
  Style.styleSheet
    [ Style.style NoStyle []
    , Style.style DebugStyle
      [ Color.background <| Color.rgb 180 256 180
      , Border.all 2
      ]
    , Style.style HeaderStyle
      [ Color.background <| Color.rgb 0 100 180
      , Color.text <| Color.white
      ]
    ]


view : Model -> Html Msg
view ({ui} as model) =
  viewport stylesheet <|
  column NoStyle [ width fill] [ renderPageHeader, renderPageBody ]


renderPageHeader =
  row HeaderStyle [ padding 10, spacing 20 ]
    [ el NoStyle [ verticalCenter, center ] (text "x5gon")
    , el NoStyle [ verticalCenter, center ] (text "header goes here") ]


renderPageBody =
  row DebugStyle []
    [ el DebugStyle [ width (px 200) ] (text "sidebar goes here")
    , el DebugStyle [ width fill ] (text "left list goes here")
    , el DebugStyle [ width fill ] (text "right list goes here")
    ]
