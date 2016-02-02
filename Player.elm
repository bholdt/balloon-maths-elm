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

type Action = PopBalloon Int

view address model =
    div [] ((List.map (viewBalloon address) model.balloons) ++ [ text (toString model.score) ])

viewBalloon : Signal.Address Action -> Balloon.Model -> Html.Html
viewBalloon address model =
    Balloon.view address model

update action model =
    case action of
        PopBalloon value ->
            { model | score = model.score + 3 }
