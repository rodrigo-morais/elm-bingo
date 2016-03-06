module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import String exposing (toUpper, repeat)

title message times =
 message ++ " "
 |> toUpper
 |> repeat times
 |> text


pageHeader =
 h1 [ ] [ title "bingo!" 3 ]


entryItem phrase points =
 li [ ]
    [ span [ class "phrase" ]
           [ text phrase ], 
      span [ class "points" ]
           [ text (toString points) ]
    ]


entryList =
 ul [ ]
    [ entryItem "Firts Item" 300,
      entryItem "Second Item" 200
    ]


pageFooter =
 footer [ ]
        [ a [ href "http://google.com" ]
            [ text "Google" ]
        ]


view =
 div [ ]
     [
      pageHeader,
      entryList,
      pageFooter
     ]

main = view