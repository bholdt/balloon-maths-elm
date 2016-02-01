import StartApp.Simple as StartApp
import Game

main =
  StartApp.start { model = Game.model, view = Game.view, update = Game.update }
