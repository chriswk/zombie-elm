module Components.Zombie where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Window

type Action
  = NoOp

type alias Tile =
  { matched: Bool
  , peeking: Bool
  , matched: Bool
  , name: String
  }

type alias Model =
  { gameLength: Int
  , ticksPerSand: Int
  , remainingTicks: Int
  , peekingTicks: Int
  , tiles: List Tile
  }

newTile : String -> Tile
newTile name = Tile False False False name

gameTiles = List.map newTile ["h1", "h1", "h2", "h2", "h3", "h3", "h4", "h4", "h5", "h5"]

tileHtml : Tile -> Html
tileHtml tile =
  let
    backClassname = "back " ++ tile.name

    revealed = if tile.revealed then " revealed" else ""

    matched = if tile.matched then " match" else ""

    peeking = if tile.peeking then " peeking" else ""

    tileClass = "tile" ++ revealed ++ matched
  in
  div
    [ class "cell" ]
    [
      div [ class tileClass ]
      [
        div [ class "front" ] [],
        div [ class backClassname ] []
      ]
    ]

lineHtml : List Tile -> Html
lineHtml tileList =
  div [ class "line" ] (List.map tileHtml tileList)
