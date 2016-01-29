import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }

type State = Start | Play | Finished

type alias Question =
    { a: Int,
      b: Int
    }

type alias Player =
    { score: Int
    , question: Question
    , balloons: List Balloon
    }

type alias Balloon =
    { x: Float
    , y: Float
    , value: Int
    }

type alias Game =
    { state: State
    , player1: Player
    , player2: Player
    }

model: Game
model =
    { state = Start
    , player1 = Player 0 (Question 3 2) [ Balloon 0 2 8, Balloon 2 3 4, Balloon 3 2 8]
    , player2 = Player 0 (Question 3 9) [ Balloon 0 2 8, Balloon 2 3 4, Balloon 3 2 8]
    }


view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]


type Action = Increment | Decrement


update action model =
  case action of
    Increment ->
        { model | player1 = Player (model.player1.score + 1) model.player1.question model.player1.balloons }
    Decrement ->
        { model | player2 = Player (model.player1.score + 1) model.player1.question model.player1.balloons }
