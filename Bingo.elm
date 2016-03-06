module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import String exposing (toUpper, repeat)

import StartApp.Simple as StartApp

-- MODEL

newEntry phrase points id =
 {
  phrase = phrase,
  points = points,
  wasSpoke = False,
  id = id
 }


initialModel =
 {
  entries = [
   newEntry "Third Item" 300 3,
   newEntry "Firts Item" 100 1,
   newEntry "Second Item" 200 2
  ]
 }


-- UPDATE

type Action =
 NoOp
 | Sort

update action model =
 case action of
  NoOp ->
   model

  Sort ->
   { model | entries = List.sortBy .points model.entries }

-- VIEW


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


entryList entries =
 ul [ ] (List.map entryItem entries)


pageFooter =
 footer [ ]
        [ a [ href "http://google.com" ]
            [ text "Google" ]
        ]


view address model =
 div [ ]
     [
      pageHeader,
      entryList model.entries,
      button [ class "sort", onClick address Sort ] [ text "Sort" ],
      pageFooter
     ]

-- PUT ALL TOGETHER

main =
 StartApp.start
 {
  model = initialModel,
  view = view,
  update = update
 }