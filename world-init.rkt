#lang racket

(require "item.rkt")
(require "character.rkt")
(require "place.rkt")
(provide (all-defined-out))


;ITEMS

(define *key*
  (new item%
       [name "Key"]
       [description "A rusty old key"]))



;;;;;;;;;;;;;;;;;;;PLACES;;;;;;;;;;;;;;;;;;;;

(define *prison-cell*
  (new place%
       [name "Prison Cell"]
       [description "A cold and dark prison cell"]))

(define *corridor*
  (new place%
       [name 'Corridor]
       [description "A long corridor"]))

(define *basement*
  (new place%
       [name 'Basement]
       [description "A damp basment with rusty pipes on the walls"]))

(define *courtyard*
  (new place%
       [name 'Courtyard]
       [description "There's high wall surronding the whole courtyard and guards everywhere"]))




(send *prison-cell* add-adjacent-location! *corridor*)
(send *corridor* add-adjacent-location! *prison-cell*)
(send *corridor* add-adjacent-location! *basement*)
(send *corridor* add-adjacent-location! *courtyard*)
(send *courtyard* add-adjacent-location! *corridor*)
(send *basement* add-adjacent-location! *corridor*)
;;;;;;;;;;;;;;;;;;;CHARACTERS;;;;;;;;;;;;;;;;;;;;;


(define *player*
  (new character%
       [name 'PLAYER]
       [description "THE PLAYER"]
       [place *prison-cell*]
       [talk-line "tjoho!"]
       [inventory '(Key)]))
(send *prison-cell* add-character *player*)

(define guard
  (new character%
       [name 'Guard]
       [description "A lazy guard who hates his job"]
       [place *corridor*]
       [talk-line "Hey! Stop that!"]
       [inventory '(Key)]))
(send *corridor* add-character guard)

(define prisoner1
  (new character%
       [name "Old prisoner"]
       [description "A very old man, he seems to be a bit confused"]
       [place *courtyard*]
       [talk-line "Bla bla bla"]
       [inventory '()]))
(send *courtyard* add-character prisoner1)

(define prisoner2
  (new character%
       [name "En riktigt skum snubbe"]
       [description "asdasdasdasdas"]
       [place *courtyard*]
       [talk-line "Do you have any FÖREMÅL3?"]
       [inventory '()]))
(send *courtyard* add-character prisoner2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





