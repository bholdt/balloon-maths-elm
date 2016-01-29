import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }

type State = Start | Play | Finished

type alias Player =
    { score: Int }

type alias Balloon =
    { x: Float
    , y: Float
    , value: Int }

type alias Game =
    { state: State
    , player1: Player
    , player2: Player
    , balloons: List Balloon
    }

model: Game
model =
    { state = Start
    , player1 = Player 0
    , player2 = Player 0
    , balloons = [ Balloon 0 2 8, Balloon 2 3 4, Balloon 3 2 8]
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
        { model | player1 = Player (model.player1.score + 1) }
    Decrement ->
        { model | player2 = Player (model.player2.score + 2) }
