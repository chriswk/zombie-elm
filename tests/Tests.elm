module Tests (..) where

import ElmTest exposing (..)
import Components.Zombie exposing (Model, shuffleTiles, newTile)
import Random exposing (initialSeed)


all : Test
all =
  let
    tiles =
      List.map newTile [ "h1", "h2", "h3", "h4" ]

    seed =
      initialSeed 1

    model =
      Model seed tiles

    shuffledModel =
      shuffleTiles model

    shuffledModel2 =
      shuffleTiles model

    nextModel =
      shuffleTiles shuffledModel
  in
    suite
      "Shuffles"
      [ test "Always gives same result when initialised with same seed" (assertEqual shuffledModel.tiles shuffledModel2.tiles)
      , test "When called again with new seed gives different result" (assertNotEqual shuffledModel.tiles nextModel.tiles)
      ]
