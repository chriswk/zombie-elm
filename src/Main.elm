module Main (..) where

import Signal exposing (Signal, map)
import Random exposing (Seed)
import Html exposing (..)
import Effects exposing (Effects, Never)
import Task
import Components.Zombie exposing (..)
import StartApp
import Random exposing (initialSeed)

initialModel : AppModel
initialModel =
  { tileCount = 16
  , tiles = []
  , seed = initialSeed 5152 }

startTimeSeed : Signal Seed
startTimeSeed = Random.initialSeed << round <~ Time.startTime


init : ( AppModel, Effects Action )
init =
    let
        tiles = tilesList initialModel.seed initialModel.tileCount
        m = { initialModel | tiles = (fst tiles), seed = (snd tiles) }
    in ( m, Effects.none )


app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view }

main =
  app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
