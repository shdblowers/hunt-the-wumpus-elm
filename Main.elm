module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


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
        [ { location = 1, connections = [ 2, 5 ] }
        , { location = 2, connections = [ 1, 3 ] }
        , { location = 3, connections = [ 2, 4 ] }
        , { location = 4, connections = [ 3, 5 ] }
        , { location = 5, connections = [ 1, 4 ] }
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


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    case list of
        [] ->
            Nothing

        first :: rest ->
            if predicate first then
                Just first
            else
                find predicate rest


getConnections : Model -> List Int
getConnections model =
    case find (\room -> room.location == model.playerLocation) model.rooms of
        Just room ->
            room.connections

        Nothing ->
            []


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text ("You are in Room " ++ (toString model.playerLocation)) ]
        , div [] (List.map (\num -> button [ onClick (Move num) ] [ text ("Go to Room " ++ (toString num)) ]) (getConnections model))
        ]
