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


(define *old-key*
  (new item%
       [name "Old-key"]
       [description "An old key that is compleatly worn out, still it might have some use none the less."]))

       
(define *cell-bed*
  (new item%
       [name "Cell-bed"]
       [description "A plain stiff bed. Why couldn't the give me a better one but then agian this is a jail and not an inn."]))
  

;;;;;;;;;;;;;;;;;;;PLACES;;;;;;;;;;;;;;;;;;;;

(define *prison-cell*
  (new place%
       [name "Prison-Cell"]
       [description "A cold and dark prison cell"]))

(define *corridor*
  (new place%
       [name 'Corridor]
       [description "A long corridor"]))

(define *storage*
  (new place%
       [name 'Storage]
       [description "This room is darker then the night the first thought that ran through my mind while pondering why they only have one lonesome torch on the wall. I have the eyes of a cat though since i can spot (insert item/items) in (insert location/locations)"]))

;rework description
(define *courtyard*
  (new place%
       [name 'Courtyard]
       [description "There's high wall surronding the whole courtyard and guards everywhere"]))

(define *burial*
  (new place%
       [name 'Burial]
       [description "Just by looking around the feel of dread creept up on me. The sight is the very symol of what awaits all prisoners in this place. In one of the four corners an old man stands with eyes seemingly staring in to an another dimention."]))
;need send
       
(define *dark-cell*
  (new place%
       [name 'Dark-cell]
       [description "On the prison bed a sits that seems to be shrouded in the darkness around him. Well even though he seems to take little note of my precence better not provoke his anger though."]))
;need send

(define *hospice*
  (new place%
       [name 'Hospice]
       [description "At the end of the room the doctor sits at his desk looking the other way and is seemingly trapped in his work. However a milk of the poppy vile is located at the desk witch could prove valuable."]))
;need send

(define *escape*
  (new place%
       [name 'Escape]
       [description "You really should not be able to read this line of dialogue through playing the game so good job!"]))

       

;;;;;;;;;;;;;;;;;;;CHARACTERS;;;;;;;;;;;;;;;;;;;;;


(define *player*
  (new character%
       [name 'PLAYER]
       [description "THE PLAYER"]
       [place *prison-cell*]
       [talk-line "tjoho!"]
       [inventory '()]))

(define *guard*
  (new character%
       [name 'Guard]
       [description "A lazy guard who hates his job"]
       [place *corridor*]
       [talk-line "Hey! Stop that!"]
       [inventory '()]))

(define *prisoner1*
  (new character%
       [name "Old-prisoner"]
       [description "A very old man, he seems to be a bit confused"]
       [place *courtyard*]
       [talk-line "Bla bla bla"]
       [inventory '()]))

(define *prisoner2*
  (new character%
       [name "Wierdo"]
       [description "asdasdasdasdas"]
       [place *courtyard*]
       [talk-line "Do you have any FÖREMÅL3?"]
       [inventory '()]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;send commands
(send *prison-cell* add-character *player*)
(send *corridor* add-character *guard*)
(send *courtyard* add-character *prisoner1*)
(send *courtyard* add-character *prisoner2*)
;(send *prison-cell* add-adjacent-location! *corridor*)
;(send *corridor* add-adjacent-location! *prison-cell*)
;(send *corridor* add-adjacent-location! *basement*)
;(send *corridor* add-adjacent-location! *courtyard*)
;(send *courtyard* add-adjacent-location! *corridor*)
;(send *basement* add-adjacent-location! *corridor*)
(send *player* add-item *old-key*)

