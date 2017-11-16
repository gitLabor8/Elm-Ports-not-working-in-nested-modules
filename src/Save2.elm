module Save2 exposing (..)

{--


--}

import Debug exposing (crash, log)
import Html exposing (..)
import Html.Attributes exposing (class, downloadAs, href, id, placeholder, type_)
import Html.Events exposing (on, onClick, onInput)
import Http exposing (encodeUri)
import Json.Decode exposing (succeed)
import Ports exposing (JsonPortData, fileContentRead, fileSelected)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model =
    { name : String
    }


init : ( Model, Cmd Msg )
init =
    ( { name = "Default" }
    , Cmd.none
    )


type Msg
    = JsonSelected String
    | JsonRead JsonPortData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JsonSelected inputBoxId ->
            ( model
            , fileSelected inputBoxId
            )

        JsonRead data ->
            ( Debug.log "In update: JsonRead " { model | name = data.filename }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead JsonRead


view : Model -> Html Msg
view model =
    div []
        [ text model.name
        , br [] []
        , uploadButton --<| Debug.log "Encoded Json: " <| toJson model
        ]


uploadButton : Html Msg
uploadButton =
    let
        ownId =
            "jsonUploadButton"
    in
    div [ class "jsonWrapper" ]
        [ input
            [ type_ "file"
            , id ownId
            , on "change"
                (succeed <| JsonSelected ownId)
            ]
            []
        ]
