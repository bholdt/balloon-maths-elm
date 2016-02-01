module Player where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import Question
import Balloon

type alias Model =
    { score: Int
    , question: Question.Model
    , balloons: List Balloon.Model
    }

view address model =
    div [] ((List.map (Balloon.view address) model.balloons) ++ [ text (toString model.score) ])

type Action = Increment | Decrement

update action model =
    case action of
        Increment ->
            { model | score = model.score + 1 }
        Decrement ->
            { model | score = model.score - 1 }
