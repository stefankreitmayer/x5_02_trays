module View exposing (view)

import Html exposing (Html)
import Color exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Element.Input as Input

import Style
import Style.Color as Color
import Style.Font as Font
import Style.Border as Border
import Style.Shadow as Shadow

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Resource exposing (..)

import Msg exposing (..)


type MyStyles
  = NoStyle
  | DebugStyle
  | H2Style
  | HeaderStyle
  | SidebarStyle
  | ResourceStyle
  | ResourceTitleStyle
  | HintStyle
  | ProjectStyle


stylesheet =
  Style.styleSheet
    [ Style.style NoStyle []
    , Style.style DebugStyle
      [ Color.background <| Color.rgb 210 210 210
      , Border.all 2
      ]
    , Style.style H2Style
      [ Color.text <| Color.rgb 50 50 50
      , Font.size 24
      ]
    , Style.style HeaderStyle
      [ Color.background <| Color.rgb 0 100 180
      , Color.text <| Color.white
      ]
    , Style.style SidebarStyle
      [ Color.background <| Color.rgb 50 50 50
      , Color.text <| Color.white
      ]
    , Style.style ResourceStyle
      [ Color.background <| Color.white
      , Color.text <| Color.black
      , Shadow.simple
      ]
    , Style.style ResourceTitleStyle
      [ Color.text <| Color.rgb 50 50 50
      , Font.size 16
      , Font.weight 600
      ]
    , Style.style HintStyle
      [ Color.text <| Color.rgb 120 120 120
      ]
    , Style.style ProjectStyle
      [ Border.left 2
      ]
    ]


view : Model -> Html Msg
view ({ui} as model) =
  viewport stylesheet <|
  column NoStyle [ height fill ] [ renderPageHeader, renderPageBody model ]


renderPageHeader =
  row HeaderStyle [ padding 10, spacing 20 ]
    [ el NoStyle [] (text "x5gon") ]


renderPageBody model =
  row DebugStyle [ height fill ]
    -- [ renderSideBar
    [ renderCatalogue model
    , renderProject model.projectResources
    ]


-- renderSideBar =
--   column SidebarStyle [ width (px 200), padding 10 ]
--     [ el NoStyle [] (text "[project selector goes here]")
--     ]


renderCatalogue model =
  column NoStyle [ width (percent 50), padding 10, spacing 10 ]
    [ renderSearchTextField
    , renderSearchResults model.searchResults
    ]


renderSearchTextField =
  -- TODO wrap in search node, see http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element
  Input.search NoStyle [ padding 3 ]
    { onChange = ChangeSearchString
    , value = "machine learning introduction"
    , label = Input.labelLeft <| el NoStyle [ padding 3 ] (text "Search for topic:")
    , options = []
    }


renderSearchResults : List Resource -> Element MyStyles variation Msg
renderSearchResults resources =
  resources
  |> List.map renderSearchResult
  |> (::) (renderNumberOfSearchResults (List.length resources))
  |> column NoStyle [ width fill, spacing 10 ]
  |> List.singleton
  |> column NoStyle [ width fill, height fill, spacing 10, yScrollbar ]


renderSearchResult resource =
  row NoStyle [ spacing 10 ]
    [ renderResource resource
    , button NoStyle [ padding 10, onClick (AddResourceToProject resource) ] (text "Add") |> el NoStyle []
    ]


renderNumberOfSearchResults : Int -> Element MyStyles variation Msg
renderNumberOfSearchResults n =
  let
      str =
        case n of
          0 -> "No results"
          1 -> "1 result"
          _ -> (toString n) ++ " results"
  in
      el HintStyle [] (text str)


renderProject resources =
  column ProjectStyle [ width (percent 50), padding 10, spacing 10 ]
    [ h2 H2Style [] (text "My dummy project")
    , renderProjectResourceList resources
    ]


renderProjectResourceList : List Resource -> Element MyStyles variation Msg
renderProjectResourceList resources =
  case resources of
    [] ->
      el HintStyle [] (text "To build your project, search for a topic and start adding resources.")

    _ ->
      resources
      |> List.map renderResource
      |> column NoStyle [ width fill, spacing 10 ]
      |> List.singleton
      |> column NoStyle [ width fill, height fill, spacing 10, yScrollbar ]


renderResource resource =
  row ResourceStyle [ padding 10, spacing 10, width fill ]
    [ decorativeImage NoStyle [ width (px 150), maxHeight (px 80) ] { src = "images/resource_covers/" ++ resource.coverImageStub ++ ".png" }
    , paragraph ResourceTitleStyle [] [ text resource.title ]
    ]
