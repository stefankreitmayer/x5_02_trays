module View exposing (view)

import Html exposing (Html)
import Color exposing (..)
import Set exposing (Set)
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
  | ProjectTitleStyle
  | H4Style
  | TagStyle
  | AddButtonCircleStyle
  | CloseButtonStyle
  | ModalityDistributionStyle
  | ModalityStylePresent
  | ModalityStyleNotPresent


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
      [ Border.right 2
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
      [ Color.background <| Color.rgb 80 80 80
      , Color.text <| Color.rgb 230 230 230
      , Shadow.simple
      ]
    -- , Style.style ProjectTitleStyle
    --   [ Font.size 16
    --   , Font.weight 600
    --   ]
    , Style.style ProjectTitleStyle
      [ Color.text <| Color.rgb 150 150 150
      , Font.size 24
      ]
    , Style.style TagStyle
      [ Border.all 1
      , Border.rounded 2
      , Color.border <| Color.rgb 200 200 200
      , Font.size 13
      ]
    , Style.style H4Style
      [ Font.weight 600
      ]
    , Style.style AddButtonCircleStyle
      [ Color.border <| Color.rgb 100 100 100
      , Border.all 1
      ]
    , Style.style CloseButtonStyle
      [ Color.text <| Color.rgb 70 70 70
      ]
    , Style.style ModalityDistributionStyle
      [ Color.background <| Color.rgb 50 50 50
      ]
    , Style.style ModalityStylePresent
      [ Color.text <| Color.rgb 80 180 80
      ]
    , Style.style ModalityStyleNotPresent
      [ Color.text <| Color.rgb 180 180 180
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
    [ renderProject model
    , renderCatalogue model
    ]


-- renderSideBar =
--   column SidebarStyle [ width (px 200), padding 10 ]
--     [ el NoStyle [] (text "[project selector goes here]")
--     ]


renderCatalogue model =
  column NoStyle [ width (percent 45), padding 10, spacing 10 ]
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
  column ProjectStyle [ width (percent 55) ]
    [ renderProjectOverview model
    , column NoStyle [ height fill, padding 10, spacing 10 ]
        [ renderItems model
        ]
    ]


renderItems : Model -> Element MyStyles variation Msg
renderItems model =
  case model.projectResources of
    [] ->
      el HintStyle [ height fill, paddingTop 10 ] (text "To build your project, search for a topic and start adding items.")

    resources ->
      resources
      |> List.map (renderItem model)
      |> Keyed.column NoStyle [ width fill, height fill, spacing 10 ]
      |> List.singleton
      |> column NoStyle [ width fill, height fill, spacing 10, yScrollbar ]


renderProjectOverview : Model -> Element MyStyles variation Msg
renderProjectOverview model =
  column ProjectOverviewStyle [ padding 10, spacing 5 ]
    [ h2 ProjectTitleStyle [] (text "Computational Thinking for age 9")
    , renderTotalWorkload model
    , renderModalityDistribution model
    -- , h4 H4Style [] (text "Relevant tags")
    -- , renderRelevantTags model
    -- , h4 H4Style [] (text "Suggested tags (click to add)")
    -- , renderSuggestedTags model
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


renderModalityDistribution model =
  let
      resources = model.projectResources
      count fn =
        model.projectResources
        |> List.map (\resource -> if fn resource then 1 else 0)
        |> List.sum
      modality label fn =
        label ++ ": " ++ (count fn |> toString)
        |> text
        |> el (if (count fn > 0) then ModalityStylePresent else ModalityStyleNotPresent) []
  in
      column ModalityDistributionStyle [ spacing 3, padding 10 ]
        [ modality "To watch" (\{tags} -> (tags |> Set.member "video") || (tags |> Set.member "course"))
        , modality "To listen" (\{tags} -> (tags |> Set.member "podcast") || (tags |> Set.member "audiobook"))
        , modality "To read" (\{tags} -> (tags |> Set.member "article") || (tags |> Set.member "book"))
        , modality "To practice" (\{tags} -> (tags |> Set.member "course") || (tags |> Set.member "quiz"))
        , modality "To socialise" (\{tags} -> (tags |> Set.member "meetup group"))
        , modality "To attend" (\{tags} -> (tags |> Set.member "event"))
        , modality "To visit" (\{tags} -> (tags |> Set.member "meetup group"))
        ]


-- renderRelevantTags model =
--   model.relevantTags
--   |> Set.toList
--   |> List.map renderRelevantTag
--   |> Keyed.wrappedRow NoStyle [ spacing 5 ]


-- renderSuggestedTags model =
--   let
--       tags =
--         model.searchResults
--         |> List.foldr (\resource tags -> tags |> Set.union resource.tags) Set.empty
--   in
--       Set.diff tags model.relevantTags
--       |> Set.toList
--       |> List.map renderSuggestedTag
--       |> Keyed.wrappedRow NoStyle [ spacing 5 ]


renderSearchResultResource model resource =
  row ResourceStyle [ padding 10, spacing 10, width fill ]
    [ decorativeImage NoStyle [ width (px 150), maxHeight (px 80) ] { src = "images/resource_covers/" ++ resource.coverImageStub ++ ".png" }
    , column NoStyle [ spacing 3, width fill ]
      [ paragraph ResourceTitleStyle [] [ text resource.title ]
      , el HintStyle [ width fill ] (text resource.date)
      , renderTagList resource
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
                , renderTagList resource
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


renderTagList resource =
  resource.tags
  |> Set.toList
  |> List.map renderTag
  |> row NoStyle [ spacing 5 ]


renderTag str =
  el TagStyle [ paddingXY 2 1 ] (text str)


-- renderRelevantTag str =
--   row TagStyle [ paddingXY 2 1, spacing 3 ]
--   [ text str
--   -- alternatively, use "✖"
--   , text "×" |> button CloseButtonStyle [ onClick (RemoveRelevantTag str) ]
--   ]
--   |> (,) str


-- renderSuggestedTag str =
--   button TagStyle [ paddingXY 2 1, onClick (AddRelevantTag str) ] (text str)
--   |> (,) str


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
      renderAnnotation name =
        Input.text AnnotationInputStyle []
          { onChange = ChangeAnnotation resource name
          , value = getAnnotation model resource name
          , label = Input.labelLeft <| el NoStyle [] (text name)
          , options = []
          }
  in
      column AnnotationsStyle [ spacing 3, padding 5 ]
        (itemAnnotation |> List.map renderAnnotation)


renderItemDropmenu model resource button =
  if model.itemDropmenu == Just resource then
    button
    |> below [ el DropmenuStyle [ alignRight, paddingXY 10 5, onClick (RemoveResourceFromProject resource) ] (text "Remove") ]
  else
    button
