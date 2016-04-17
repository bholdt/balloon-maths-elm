module Question where
import Html exposing (..)
import Html.Events exposing (..)
import Effects exposing (Effects, Never)
import Task
import StartApp
import Array

myArray = Array.fromList [1..5]
myItem = Array.get 2 myArray

type alias Model = {
      question: String
    , difficulty: Int
    , answers: List Answer
}

type Action = AnswerQuestion Int | NoOp

type alias Answer = {
      text: String
    , correct: Bool
}

score model = 
    if model.answer == model.correctAnswer then
        model.difficulty
    else
        0

viewAnswer address model = 
        div [] (List.map (\a -> if a.correct then text a.text else text "") model.answers)

viewAnswerButton address model = 
    let
        score = if model.correct then 1 else 0
    in
        button [ onClick address (AnswerQuestion score) ] [ text model.text ]

view address model = 
    div [] [ text model.question, div [] (List.map (viewAnswerButton address) model.answers) ]

update : Action -> Model -> ( Model, Effects Action )
update action model =
    (model, Effects.none)
