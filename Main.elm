module Main (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Effects exposing (Effects, Never)
import Task
import StartApp
import Question
import Array

-- ACTIONS

type Action
  = NoOp | NextQuestion | AnswerQuestion Question.Action


-- MODEL

type alias Model =
  {   questions: List Question.Model
      , currentQuestion: Int
      , showAnswer: Bool
      , score: Int
  }

initialModel : Model
initialModel = { questions = 
        [
             Question.Model "Capital of Namibia?" 1 [ (Question.Answer "Windhoek" True), (Question.Answer "SOmething" False), (Question.Answer "Another one" False) ]
           , Question.Model "Capital of Australia?" 1 [ (Question.Answer "Canberra" True), (Question.Answer "Sydney" False)]
        ]
        , currentQuestion = 0
        , showAnswer = False
        , score = 0
    }


-- UPDATE

update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        NextQuestion ->
            let m = { model | currentQuestion = model.currentQuestion + 1, showAnswer = False }
            in
                ( m , Effects.none)
        AnswerQuestion answer ->
            let 
              score = case answer of
                Question.NoOp -> 0
                Question.AnswerQuestion a -> a
              m = { model | showAnswer = True, score = model.score + score }
            in (m, Effects.none)
        NoOp -> ( model, Effects.none )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let arrayQuestions = Array.fromList model.questions
      currentQuestion = Array.get model.currentQuestion arrayQuestions
      forwardAddress = Signal.forwardTo address AnswerQuestion
      display = case currentQuestion of
                    Nothing -> viewScore address model
                    Just a -> if model.showAnswer then (Question.viewAnswer forwardAddress a) else (Question.view forwardAddress a)
  in
    div
        []
        [ display, button [ onClick address NextQuestion ] [ text "Next" ] ]

viewScore address model =
    div [] [ span [] [ text (toString model.score) ] ]


-- START APP

init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )

app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }

main : Signal.Signal Html
main =
  app.html

port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
