module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { location : Int, rooms : List Int }


model : Model
model =
    { location = 1, rooms = [ 1, 2, 3 ] }



-- UPDATE


type Msg
    = Move Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Move room ->
            { model | location = room }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text ("You are in Room " ++ (toString model.location)) ]
        , div [] (List.map (\num -> button [ onClick (Move num) ] [ text ("Go to Room " ++ (toString num)) ]) model.rooms)
        ]
