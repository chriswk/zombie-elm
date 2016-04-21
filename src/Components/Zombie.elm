module Components.Zombie where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Window
import Effects exposing (Effects)
import Random exposing (Seed)

type Action
  = NoOp

type alias Tile =
  { revealed: Bool
  , name: String
  }

type alias Model =
  { seed: Seed
  , tiles: List Tile
  }

newTile : String -> Tile
newTile name = Tile False name

revealedTile : String -> Tile
revealedTile name = Tile True name

gameTiles = List.map newTile ["h1", "h1", "h2", "h2", "h3", "h3", "h4", "h4", "h5", "h5", "gy", "zo", "zo", "zo"]

tileHtml : Tile -> Html
tileHtml tile =
  let
    backClassname = "back " ++ tile.name

    revealed = if tile.revealed then " revealed" else ""

    tileClass = "tile" ++ revealed
  in
  div
    [ class "cell" ]
    [
      div [ class tileClass ]
      [
        div [ class "front" ] [ ],
        div [ class backClassname ] []
      ]
    ]

lineHtml : List Tile -> Html
lineHtml tileList =
  div [ class "line" ] (List.map tileHtml tileList)

boardHtml : List (List Tile) -> Html
boardHtml tileList = div [ class "board clearfix" ]
                         (List.map lineHtml tileList)


view : Signal.Address Action -> Model -> Html
view address model = boardHtml [[revealedTile "h1", revealedTile "h1", revealedTile "h2", revealedTile "h2"],
          [revealedTile "h3", revealedTile "h3", revealedTile "h4", revealedTile "h4"]]

update : Action -> Model -> (Model, Effects Action)
update action model =
  (model, Effects.none)
