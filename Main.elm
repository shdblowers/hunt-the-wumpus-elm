module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import ListExtras


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Room =
    { location : Int, connections : List Int }


type alias Model =
    { playerLocation : Int, rooms : List Room }


model : Model
model =
    { playerLocation = 1
    , rooms =
        [ { location = 1, connections = [ 2, 5, 6 ] }
        , { location = 2, connections = [ 1, 3, 8 ] }
        , { location = 3, connections = [ 2, 4, 10 ] }
        , { location = 4, connections = [ 3, 5, 12 ] }
        , { location = 5, connections = [ 1, 4, 14 ] }
        , { location = 6, connections = [ 1, 7, 15 ] }
        , { location = 7, connections = [ 6, 8, 16 ] }
        , { location = 8, connections = [ 2, 7, 9 ] }
        , { location = 9, connections = [ 8, 10, 17 ] }
        , { location = 10, connections = [ 3, 9, 11 ] }
        , { location = 11, connections = [ 10, 12, 18 ] }
        , { location = 12, connections = [ 4, 11, 13 ] }
        , { location = 13, connections = [ 12, 14, 19 ] }
        , { location = 14, connections = [ 5, 13, 15 ] }
        , { location = 15, connections = [ 14, 6, 20 ] }
        , { location = 16, connections = [ 7, 17, 20 ] }
        , { location = 17, connections = [ 9, 16, 18 ] }
        , { location = 18, connections = [ 11, 17, 19 ] }
        , { location = 19, connections = [ 13, 18, 20 ] }
        , { location = 20, connections = [ 15, 16, 19 ] }
        ]
    }



-- UPDATE


type Msg
    = Move Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Move room ->
            { model | playerLocation = room }



-- VIEW


getConnections : Model -> List Int
getConnections model =
    case ListExtras.find (\room -> room.location == model.playerLocation) model.rooms of
        Just room ->
            room.connections

        Nothing ->
            []


view : Model -> Html Msg
view model =
    let
        roomConnections =
            getConnections model
    in
        div []
            [ div [] [ text ("You are in Room " ++ (toString model.playerLocation)) ]
            , div []
                (List.map
                    (\roomLocation ->
                        button [ onClick (Move roomLocation) ]
                            [ text ("Go to Room " ++ (toString roomLocation)) ]
                    )
                    roomConnections
                )
            ]
