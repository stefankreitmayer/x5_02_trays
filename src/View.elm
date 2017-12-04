module View exposing (view)

import Html exposing (Html)
import Color exposing (..)
-- import Debug exposing (log)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick, onCheck)
import Element.Input as Input
import Element.Keyed as Keyed

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
  | DropmenuStyle
  | EllipsisStyle
  | AnnotationsStyle
  | AnnotationInputStyle
  | ProjectOverviewStyle
  | ProjectOverviewHeadingStyle


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
    , Style.style DropmenuStyle
      [ Color.background <| Color.white
      , Color.text <| Color.black
      , Color.border <| Color.rgb 200 200 200
      , Border.all 1
      , Shadow.simple
      ]
    , Style.style EllipsisStyle
      [ Style.opacity 0.66
      ]
    , Style.style AnnotationsStyle
      [ Border.top 1
      , Border.left 1
      , Color.border <| Color.rgb 200 200 200
      , Color.background <| Color.rgb 230 230 230
      ]
    , Style.style AnnotationInputStyle
      [ Border.bottom 1
      , Color.border <| Color.rgb 200 200 200
      , Shadow.simple
      ]
    , Style.style ProjectOverviewStyle
      [ Color.background <| Color.white
      , Color.border <| Color.rgb 100 100 100
      , Border.top 1
      ]
    , Style.style ProjectOverviewHeadingStyle
      [ Font.size 16
      , Font.weight 600
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
    , renderProject model
    ]


-- renderSideBar =
--   column SidebarStyle [ width (px 200), padding 10 ]
--     [ el NoStyle [] (text "[project selector goes here]")
--     ]


renderCatalogue model =
  column NoStyle [ width (percent 40), padding 10, spacing 10 ]
    [ renderSearchTextField
    , renderSearchResults model
    ]


renderSearchTextField =
  -- TODO wrap in search node, see http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element
  Input.search NoStyle [ padding 3 ]
    { onChange = ChangeSearchString
    , value = "machine learning introduction"
    , label = Input.labelLeft <| el NoStyle [ padding 3 ] (text "Search for topic:")
    , options = []
    }


renderSearchResults : Model -> Element MyStyles variation Msg
renderSearchResults ({searchResults} as model) =
  searchResults
  |> List.map (renderSearchResult model)
  |> (::) (renderNumberOfSearchResults (List.length searchResults))
  |> column NoStyle [ width fill, spacing 10 ]
  |> List.singleton
  |> column NoStyle [ width fill, height fill, spacing 10, yScrollbar ]


renderSearchResult model resource =
  let
    addButton =
      if List.member resource model.projectResources then
        el HintStyle [ padding 3 ] (text "Added")
      else
        button NoStyle [ padding 10, onClick (AddResourceToProject resource) ] (text "Add") |> el NoStyle []
  in
      row NoStyle [ spacing 10 ]
        [ renderSearchResultResource model resource
        , addButton
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


renderProject model =
  column ProjectStyle [ width (percent 60) ]
    [ column NoStyle [ height fill, padding 10, spacing 10 ]
        [ h2 H2Style [] (text "My dummy project")
        , renderItems model
        ]
    , renderProjectOverview model
    ]


renderItems : Model -> Element MyStyles variation Msg
renderItems model =
  case model.projectResources of
    [] ->
      el HintStyle [ height fill ] (text "To build your project, search for a topic and start adding items.")

    resources ->
      resources
      |> List.map (renderItem model)
      |> Keyed.column NoStyle [ width fill, height fill, spacing 10 ]
      |> List.singleton
      |> column NoStyle [ width fill, height fill, spacing 10, yScrollbar ]


renderProjectOverview : Model -> Element MyStyles variation Msg
renderProjectOverview model =
  column ProjectOverviewStyle [ padding 10, spacing 5 ]
    [ h3 ProjectOverviewHeadingStyle [] (text "Project Summary")
    , renderTotalWorkload model
    ]


renderTotalWorkload model =
  let
      hours =
        model.projectResources
        |> List.map (workloadInHours model)
        |> List.sum
        |> toString
  in
     "Total workload: " ++ hours ++ " hours" |> text |> el NoStyle []


renderSearchResultResource model resource =
  row ResourceStyle [ padding 10, spacing 10, width fill ]
    [ decorativeImage NoStyle [ width (px 150), maxHeight (px 80) ] { src = "images/resource_covers/" ++ resource.coverImageStub ++ ".png" }
    , column NoStyle [ spacing 3, width fill ]
      [ paragraph ResourceTitleStyle [] [ text resource.title ]
      , el HintStyle [ width fill ] (text resource.date)
      , el NoStyle [ width fill, alignRight ] (text resource.kind)
      , renderSearchResultDetails model resource
      ]
    ]


-- returns a Keyed element
renderItem : Model -> Resource -> (String, Element MyStyles variation Msg)
renderItem model resource =
  let
      element =
        column ResourceStyle [ padding 10, spacing 10, width fill ]
          [ row NoStyle [ spacing 10 ]
              [ decorativeImage NoStyle [ width (px 150), maxHeight (px 80) ] { src = "images/resource_covers/" ++ resource.coverImageStub ++ ".png" }
              , column NoStyle [ spacing 3, width fill ]
                [ paragraph ResourceTitleStyle [] [ text resource.title ]
                , el HintStyle [ width fill ] (text resource.date)
                , el NoStyle [ width fill, alignRight ] (text resource.kind)
                , renderItemDetails model resource
                ]
              , column NoStyle [ spacing 10 ]
                [ decorativeImage EllipsisStyle [ width (px 20) ] { src = "images/icons/ellipsis.png" }
                  |> button NoStyle [ onClick (ToggleItemDropmenu resource), alignRight ]
                  |> renderItemDropmenu model resource
                  |> el NoStyle []
                  , Input.checkbox NoStyle []
                      { onChange = ToggleItemOptional resource
                      , checked = isItemOptional model resource
                      , label = el NoStyle [] (text "optional")
                      , options = []
                      }
                ]
              ]
            , renderItemAnnotations model resource
          ]
  in
      (resource.url, element)


renderSearchResultDetails model resource =
  let
      (collapseButton, details) =
        if List.member resource.url model.expandedSearchResults then
          ( button NoStyle [ paddingXY 4 1, onClick (HideDetails resource), alignRight ] (text "Hide")
          , [ paragraph NoStyle [] [ text resource.url ] |> newTab resource.url ]
          )
        else
          ( button NoStyle [ paddingXY 4 1, onClick (ShowDetails resource), alignRight ] (text "More")
          , [])
  in
      column NoStyle [ spacing 3 ]
        (collapseButton :: details)


renderItemDetails model resource =
  column NoStyle [ spacing 3 ]
    [ paragraph NoStyle [] [ text resource.url ] |> newTab resource.url ]


renderItemAnnotations model resource =
  let
      renderAttribute name =
        Input.text AnnotationInputStyle []
          { onChange = ChangeAnnotation resource name
          , value = getAnnotation model resource name
          , label = Input.labelLeft <| el NoStyle [] (text name)
          , options = []
          }
  in
      column AnnotationsStyle [ spacing 3, padding 5 ]
        (itemAttributes |> List.map renderAttribute)


renderItemDropmenu model resource button =
  if model.itemDropmenu == Just resource then
    button
    |> below [ el DropmenuStyle [ alignRight, paddingXY 10 5, onClick (RemoveResourceFromProject resource) ] (text "Remove") ]
  else
    button
