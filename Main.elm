import StartApp.Simple as StartApp
import Html exposing (div, button, text)
import Html.Events exposing (onClick)

main =
  StartApp.start { model = game, view = view, update = update }

type State = Start | Play | Finished

type Action = PopBalloon Player Int

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
    , players = [ Player 1 0 (Question 3 2) [ Balloon 3, Balloon 24, Balloon 23 ]
                , Player 2 0 (Question 3 5) [ Balloon 8, Balloon 15, Balloon 14 ] ]
    }


view address model =
    div []
      ((List.map (playerView address) model.players) ++ [ text (toString model.state) ])


playerView address model =
    div [] ([ text ("Player " ++ (toString model.id))
           , questionView address model.currentQuestion
           , text ("Score " ++ (toString model.score))
           ] ++ (balloonListView address model))

questionView address model =
  text ("Question" ++ (toString model.a) ++ " x " ++ (toString model.b))

balloonListView address model =
    List.map (balloonView address model) model.balloons

balloonView address player model =
    button [ onClick address (PopBalloon player model.value) ] [ text ("Balloon " ++ (toString model.value)) ]

updateScore player answer =
  if (player.currentQuestion.a * player.currentQuestion.b) == answer then
    { player | score = player.score + 2 }
  else
    { player | score = player.score - 1 }

update action model =
    case action of
        PopBalloon player value ->
          let updatePlayer p =
            if p.id == player.id then
              updateScore p value
            else
              p
          in
              { model | players = List.map updatePlayer model.players }
