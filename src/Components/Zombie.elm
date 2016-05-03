module Components.Zombie (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Effects exposing (Effects)
import Random exposing (Seed, generate)
import Exts.List exposing (chunk)
import Array exposing (toList, fromList)
import Random.Array exposing (shuffle)
import Signal exposing (Signal, Address)


type Action
  = NoOp
  | Peeking Int Bool


type alias Tile =
  { id : Int
  , revealed : Bool
  , peeking : Bool
  , name : String
  }


type alias Model =
  { seed : Seed
  , tiles : List Tile
  }



newTile : Int -> String -> Tile
newTile id name =
  Tile id False False name


revealedTile : Int -> String -> Tile
revealedTile id name =
  Tile id True False name


shuffleTiles : Model -> Model
shuffleTiles model =
  let
    tilesArray =
      fromList model.tiles

    generator =
      shuffle tilesArray

    shuffles =
      generate generator model.seed

    shuffledTiles =
      toList (fst shuffles)

    newSeed =
      snd shuffles
  in
    { model | tiles = shuffledTiles, seed = newSeed }


gameTiles =
  List.indexedMap
    newTile
    [ "h1"
    , "h1"
    , "h2"
    , "h2"
    , "h3"
    , "h3"
    , "h4"
    , "h4"
    , "h5"
    , "h5"
    , "h6"
    , "h6"
    , "gy"
    , "zo"
    , "zo"
    , "zo"
    ]


tileHtml : Address Action -> Tile -> Html
tileHtml address tile =
  let
    backClassname =
      "back " ++ tile.name

    revealed =
      if tile.revealed then
        " revealed"
      else
        ""

    tileClass =
      "tile" ++ revealed
  in
    div
      [ class "cell" ]
      [ div
          [ class tileClass ]
          [ div [ class "front", onClick address (Peeking tile.id True) ] []
          , div [ class backClassname ] []
          ]
      ]


lineHtml : Address Action -> List Tile -> Html
lineHtml address tileList =
  div [ class "line" ] (List.map (tileHtml address) tileList)


boardHtml : Address Action -> List (List Tile) -> Html
boardHtml address tileList =
  div
    [ class "board clearfix" ]
    (List.map (lineHtml address) tileList)

peekTile : Model -> Int -> Bool -> Model
peekTile model id peeking =
  let
    updateTile t = if t.id == id then { t | revealed = peeking } else t
  in
    { model | tiles = List.map updateTile model.tiles }

view : Address Action -> Model -> Html
view address model =
  boardHtml address (chunk 4 model.tiles)


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )
    Peeking id peek ->
      ((peekTile model id peek), Effects.none)
