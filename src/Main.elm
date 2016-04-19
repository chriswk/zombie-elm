module Main (..) where

import Signal exposing (Signal, map)
import Random exposing (Seed)
import Html exposing (..)
import Effects exposing (Effects, Never)
import Task
import Components.Zombie exposing (..)
import StartApp
import Random exposing (initialSeed)

initialModel : Model
initialModel =
  { tiles = []
  , seed = initialSeed 5152
  }

init : ( Model, Effects Action )
init =
    let
        tiles = gameTiles
        m = { initialModel | tiles = tiles }
    in ( m, Effects.none )


app : StartApp.App Model
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
