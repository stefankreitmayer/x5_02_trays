module View exposing (view)

import Html exposing (Html)
import Color exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Input as Input

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
    | SidebarStyle


stylesheet =
  Style.styleSheet
    [ Style.style NoStyle []
    , Style.style DebugStyle
      [ Color.background <| Color.rgb 210 210 210
      , Border.all 2
      ]
    , Style.style HeaderStyle
      [ Color.background <| Color.rgb 0 100 180
      , Color.text <| Color.white
      ]
    , Style.style SidebarStyle
      [ Color.background <| Color.rgb 50 50 50
      , Color.text <| Color.white
      ]
    ]


view : Model -> Html Msg
view ({ui} as model) =
  viewport stylesheet <|
  column NoStyle [ height fill ] [ renderPageHeader, renderPageBody ]


renderPageHeader =
  row HeaderStyle [ padding 10, spacing 20 ]
    [ el NoStyle [] (text "x5gon") ]


renderPageBody =
  row DebugStyle [ height fill ]
    [ renderSideBar
    , renderCatalogue
    , renderTrolley
    ]


renderSideBar =
  column SidebarStyle [ width (px 200), padding 10 ]
    [ el NoStyle [] (text "[project selector goes here]")
    ]


renderCatalogue =
  -- TODO wrap in search node, see http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element
  let
      label = Input.labelLeft <| el NoStyle [] (text "Search topic:")
  in
      column NoStyle [ width fill, padding 10 ]
        [ Input.search NoStyle []
          { onChange = ChangeSearchString
          , value = "computational thinking"
          , label = label
          , options = []
          }
        ]


renderTrolley =
  column DebugStyle [ width fill, padding 10 ]
    [ el NoStyle [ width fill, center, verticalCenter ] (text "Your selected items will go here.")
    ]
