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
  wasSpoken = False,
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
 | Delete Int
 | Mark Int

update action model =
 case action of
  NoOp ->
   model

  Sort ->
   { model | entries = List.sortBy .points model.entries }

  Delete id ->
   let
    remainingEntries =
     List.filter (\e -> e.id /= id) model.entries
   in
    { model | entries = remainingEntries }

  Mark id ->
   let
    updateEntry e =
     if e.id == id then { e | wasSpoken = (not e.wasSpoken) } else e
   in
    {model | entries = List.map updateEntry model.entries }


-- VIEW


title message times =
 message ++ " "
 |> toUpper
 |> repeat times
 |> text


pageHeader =
 h1 [ ] [ title "bingo!" 3 ]


totalPoints entries =
 let
  spokenEntries = List.filter .wasSpoken entries
 in
  List.sum (List.map .points spokenEntries)


totalItem total =
 li
  [ class "total" ]
  [ span [ class "labels" ] [ text "Total" ],
    span [ class "points" ] [ text (toString total) ]
  ]


entryItem address entry =
 li
  [ classList [ ("highlight", entry.wasSpoken)],
    onClick address (Mark entry.id)
  ]
  [ span [ class "phrase" ]
         [ text entry.phrase ], 
    span [ class "points" ]
         [ text (toString entry.points) ],
    button [ class "delete", onClick address (Delete entry.id) ]
           [ text "Delete" ]
  ]


entryList address entries =
 let
  entryItems = List.map (entryItem address) entries
  items = entryItems ++ [ totalItem (totalPoints entries) ]
 in
  ul [ ] items


pageFooter =
 footer [ ]
        [ a [ href "http://google.com" ]
            [ text "Google" ]
        ]


view address model =
 div [ ]
     [
      pageHeader,
      entryList address model.entries,
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