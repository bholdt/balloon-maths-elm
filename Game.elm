module Game where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import Player
import Question
import Balloon


type State = Start | Play | Finished

type alias Game =
    { state: State
    , player1: Player.Model
    , player2: Player.Model
    }

model: Game
model =
    { state = Start
    , player1 = Player.Model 0 (Question.Model 3 2) [ Balloon.Model 8, Balloon.Model 2, Balloon.Model 3 ]
    , player2 = Player.Model 0 (Question.Model 3 9) [ Balloon.Model 8, Balloon.Model 2, Balloon.Model 3 ]
    }


view address model =
    div [] [ Player.view address model.player1 ]

update action model =
    { model | player1 = Player.Model 2 (Question.Model 3 2) [ Balloon.Model 8, Balloon.Model 2, Balloon.Model 3 ] }