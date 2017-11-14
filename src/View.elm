module View exposing (view)

import Html exposing (Html, div, p, button, h1, input, span, select, label, table, tr, td)
import Html.Attributes exposing (class, classList, style, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Dict

import Model exposing (..)
import Model.Ui exposing (..)
import Model.Resource exposing (..)
import Msg exposing (..)

import Json.Encode as Json
import Debug exposing (log)


view : Model -> Html Msg
view ({ui} as model) =
  case ui.screen of
    MainScreen ->
      renderMainScreen model


renderMainScreen : Model -> Html Msg
renderMainScreen model =
  [ renderNotification model
  , renderPageHeader
  , renderSearchResults model ]
  |> div [ class "PageContainer" ]


renderPageHeader : Html Msg
renderPageHeader =
  let
      fakeSearchTextField =
        Html.img [ Html.Attributes.src "images/fakeSearchTextField.png" ] []
      children =
        [ fakeSearchTextField ]
  in
      div [ class "PageHeader" ] children

renderSearchResults : Model -> Html Msg
renderSearchResults model =
  let
      heading = p [ class "SearchResults__NumberOfResults" ] [ Html.text ("About " ++ (model.resources |> List.length |> toString) ++ " results") ]
      resources = model.resources |> List.map renderResource |> div []
  in
     div [] [ heading, resources ]


renderResource : Resource -> Html Msg
renderResource ({annotations} as resource) =
  let
      coverImage =
        Html.img [ Html.Attributes.src ("images/resource_covers/" ++ resource.coverImageStub ++ ".png") ] []
      title =
        Html.h3 [] [ resource.title |> Html.text ]
      date =
        p [ class "SearchListView__Item__Date" ] [ resource.date |> Html.text ]
      domain =
        Html.cite [] [ resource.url |> String.split "/" |> List.take 3 |> List.drop 2 |> String.join "" |> Html.text ]
      iconsList =
        case resource.kind of
          "" ->
            []

          "podcast" ->
            [ Html.img [ Html.Attributes.src "images/icons/audio.svg" ] [] ]

          "article" ->
            [ Html.img [ Html.Attributes.src "images/icons/eyes.svg" ] [] ]

          "book" ->
            [ Html.img [ Html.Attributes.src "images/icons/eyes.svg" ] [] ]

          "video" ->
            [ Html.img [ Html.Attributes.src "images/icons/video.svg" ] [] ]

          "course" ->
            [ Html.img [ Html.Attributes.src "images/icons/video.svg" ] []
            , Html.img [ Html.Attributes.src "images/icons/audio.svg" ] []
            , Html.img [ Html.Attributes.src "images/icons/eyes.svg" ] [] ]

          str ->
            [ span [] [ str |> Html.text] ]
      icons =
        iconsList |> div [ class "SearchListView__Item__Icons" ]
      left =
        div [ class "SearchListView__Item__Left" ] [ coverImage ]
      right =
        div [ class "SearchListView__Item__Right" ] [ title, domain, date, icons ]
      children =
        [ left, right ]
  in
      div [ class "SearchListView__Item" ] children


renderNotification : Model -> Html Msg
renderNotification model =
  case model.errorMsg of
    Nothing ->
      div [] []

    Just msg ->
      div [ class "Notification" ] [ Html.text msg ]
