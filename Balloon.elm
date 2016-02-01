module Balloon where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)

type alias Model =
    { value: Int }

type Action = OnClick

view address model =
    div [] [
        button [onClick address OnClick] [ text "Press"],
        text (toString model.value)
    ]
