import StartApp.Simple as StartApp
import Html exposing (div, button, text)
import Html.Events exposing (onClick)

main =
  StartApp.start { model = game, view = view, update = update }

type State = Start | Play | Finished

type Action = PopBalloon Player

type alias Game =
    { state: State
    , players: List Player
    }

type alias Player =
    { id: Int
    , score: Int
    , currentQuestion: Question
    , balloons: List Balloon
}

type alias Question =
    { a: Int
    , b: Int
    }

type alias Balloon =
    { value: Int }

game: Game
game =
    { state = Start
    , players = [ Player 1 0 (Question 3 2) [ Balloon 8, Balloon 2, Balloon 3 ]
                , Player 2 0 (Question 3 5) [ Balloon 8, Balloon 2, Balloon 3 ] ]
    }


view address model =
    div []  ((List.map (playerView address) model.players) ++ [ text (toString model.state) ])
           --, button [ onClick address (PopBalloon model.player1) ] [ text "Player 1" ]


playerView address model =
    div [] [ text (toString model.score)
           , button [ onClick address (PopBalloon model) ] [ text ("Player " ++ (toString model.id)) ]
           ]

update action model =
    case action of
        PopBalloon player ->
          let updatePlayer p = if p.id == player.id then { p | score = 4 } else p
          in
              { model | players = List.map updatePlayer model.players }
