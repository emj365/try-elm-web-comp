module Main exposing (main, opt)

import Html exposing (Html, div)
import Html.Attributes exposing (attribute, class, style)
import Json.Encode


view =
    div []
        [ echart opt
        ]


type alias EchartsOpt =
    { xAxis : { type_ : String, data : List String }
    , yAxis : { type_ : String }
    , series : List { data : List Int, type_ : String }
    }


opt : EchartsOpt
opt =
    { xAxis =
        { type_ = "category"
        , data = [ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" ]
        }
    , yAxis =
        { type_ = "value"
        }
    , series =
        [ { data = [ 150, 230, 224, 218, 135, 147, 260 ]
          , type_ = "line"
          }
        ]
    }


type alias Serie =
    { data : List Int
    , type_ : String
    }


serieJson : Serie -> Json.Encode.Value
serieJson serie =
    Json.Encode.object [ ( "type", Json.Encode.string serie.type_ ), ( "data", Json.Encode.list Json.Encode.int serie.data ) ]


optJson : EchartsOpt -> Json.Encode.Value
optJson opt_ =
    Json.Encode.object
        [ ( "xAxis"
          , Json.Encode.object
                [ ( "type", Json.Encode.string opt_.xAxis.type_ )
                , ( "data", Json.Encode.list Json.Encode.string opt_.xAxis.data )
                ]
          )
        , ( "yAxis", Json.Encode.object [ ( "type", Json.Encode.string opt_.yAxis.type_ ) ] )
        , ( "series", Json.Encode.list serieJson opt_.series )
        ]


echart : EchartsOpt -> Html msg
echart opt_ =
    div
        [ class "echart"
        , attribute "option" (Json.Encode.encode 0 (optJson opt_))
        , style "height" "500px"
        , style "width" "100%"
        ]
        []


main =
    view
