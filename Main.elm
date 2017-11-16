module Main exposing (..)

{--

  Calls Save2 and asks for

--}

import Debug exposing (crash, log)
import Html exposing (..)
import Html.Attributes exposing (class, downloadAs, href, id, placeholder, type_)
import Html.Events exposing (on, onClick, onInput)
import Http exposing (encodeUri)
import Json.Decode exposing (succeed)
import Save2 exposing (..)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { save2 : Save2.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { save2 = Tuple.first Save2.init }
    , Cmd.none
    )


type Msg
    = Save2 Save2.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Save2 saveMsg ->
            ( { model | save2 = Tuple.first (Save2.update saveMsg model.save2) }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map Save2 (Save2.subscriptions model.save2)


view : Model -> Html Msg
view model =
    div []
        [ text model.save2.name
        , br [] []
        , Html.map Save2 Save2.uploadButton
        ]
