module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import String exposing (toUpper, repeat)


newEntry phrase points id =
 {
  phrase = phrase,
  points = points,
  wasSpoke = False,
  id = id
 }


title message times =
 message ++ " "
 |> toUpper
 |> repeat times
 |> text


pageHeader =
 h1 [ ] [ title "bingo!" 3 ]


entryItem entry =
 li [ ]
    [ span [ class "phrase" ]
           [ text entry.phrase ], 
      span [ class "points" ]
           [ text (toString entry.points) ]
    ]


entryList =
 ul [ ]
    [ entryItem (newEntry "Firts Item" 300 1),
      entryItem (newEntry "Second Item" 200 2)
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