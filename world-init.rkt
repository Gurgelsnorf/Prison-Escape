#lang racket

(require "item.rkt")
(require "character.rkt")
(require "place.rkt")
(provide (all-defined-out))


;ITEMS

(define *key*
  (new item%
       [name 'Key]
       [description "A rusty old key"]))
;ska bort

(define *old-key*
  (new item%
       [name 'Old-key]
       [description "An old key that is compleatly worn out, still it might have some use none the less."]))
;in prison cell used to pick door
       
(define *cell-bed*
  (new item%
       [name 'Cell-bed]
       [description "A plain stiff bed. Why couldn't the give me a better one but then agian this is a jail and not an inn."]))
;need send useless

(define *lesser-soul*
  (new item%
       [name 'Lesser-soul]
       [description "Use the lesser soul to aquire  small amount of souls, or trade it for something valuable."]))
; send burial

(define *storage-key*
  (new item%
       [name 'Storage-key]
       [description "This key grants me access to the storage"]))
;send Lucatiel

(define *lucatiels-mask*
  (new item%
       [name 'Lucatiels-mask]
       [description "Mask attached to a ceremonial hat. Belonges to Lucatiel of Mirrah. Normally hats and masks are separate, but these two have been adjoined."]))
;gavlan has it, give it to Lucatiel

(define *torch*
  (new item%
       [name 'Torch]
       [description "A burning hot torch"]))
;in storage "burn" storage with it

(define *liquor*
  (new item%
       [name 'Liquor]
       [desription "Gives of a strong smell of alcohol making it impossible to detect any other smell or proabably any other tastes also for that matter"]))
;in storage used on guard door (with milk of the poppy in inventory) do frug the guard for the key

(define *dark-orb*
  (new item%
       [name 'Dark-orb]
       [description "A hex modified from an old sorcery by Gilleah, the father of Hexing."]))
;found in hospice

(define *Chesters-long-coat*
  (new item%
       [name 'Chesters-long-coat]
       [description "Allowes the wearer to move in silence greatly increasing the ability to sneak"]))
;aquired from Felkin

(define *milk-of-the-poppy*
  (new item%
       [name 'Milk-of-the-poppy]
       [description "A common extract used to dull pain from diesese or during surgery, the a whole bottle will easily leave anyone unconcious."]))
;in hospice can only be accessed while haveing Chester's long coat

(define *asylum-key*
  (new item%
       [name 'Asylum-key]
       [description "The key that opens the door out of this horrible place. Better use it wisly when the guards will not be able to hinder my escape."]))
;aquired from drugged guard-pate
       
;;;;;;;;;;;;;;;;;;;PLACES;;;;;;;;;;;;;;;;;;;;

(define *prison-cell*
  (new place%
       [name 'Prison-Cell]
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
       [description "There's high wall surronding the whole courtyard upon the walls seeing anyone passing through. In the north east corner a short bearded man resides."]))

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
       [description "You"]
       [place *prison-cell*]
       [talk-line "tjoho!"]
       [inventory '()]))

(define *guard-pate*
  (new character%
       [name 'Guard-Pate]
       [description "A lazy guard only looking out for himself"]
       [place *corridor*]
       [talk-line "If you think you are ever leaving that cell you have the wrong idea of this place, and I will not need to watch you starve I have wealth that needs aquiering."]
       [item-talk-line "Where did you find that key? No matter i'll just take it, maybe I can find some use for it instead."]
       [inventory '()]))
;location prison cell keeps you from leaving until you have talked to him

(define *lucatiel*
  (new character%
       [name 'Lucatiel]
       [description "Lucatiel was one a proud night of Mirrah and now wonders the land of Drangleic due to a curse she is hesitant to talk about."]
       [place *courtyard*]
       [talk-line "My name is Lucatiel and I come from the land of Mirrah. Don't mind the hollowing it is just the curse, on that note if you ever get your hand on my mask from Gavlan i would be more than pleased."]
       [item-talk-line "Thank you for keeping my sanity, take this key it might bring you more fortune than it did for me and please rememember my name for I might not."]
       [inventory '()]))
;location burial has the storage key

(define *gavlan*
  (new character%
       [name 'Gavlan]
       [description "A short man probably related to the Gyrms, however he seems only interested in wheeling and dealing"]
       [place *courtyard*]
       [talk-line "Who you? I Gavlan. Gavlan wheel? Gavlan deal. Gavlan want soul. Many many soul. Gah hah! What you want? With Gavlan, you wheel? You deal! Gah hah!"]
       [item-talk-line "Many deal...Many thanks! Gah hah!"]
       [inventory '()]))
;location courtyard, item Lucatiel's Mask

(define *felkin*
  (new character%
       [name 'Felkin]
       [description "The darkness shrouding Felkin is unnerving to the very core, none the less he might have valuable information but information is not free"]
       [place *dark-cell*]
       [talk-line "Unless you can prove that you are not afraid of embracing rhe dark we have nothing to talk about."]
       [item-talk-line "I see that you are not a person of bigotry judging before knowing anything, take the Chester's Long Coat it will help you embrace the dark and move in silence."]
       [inventory'()]))
;location dark-cell, item Chester's-long-coat

(define *licia*
  (new character%
       [name 'Licia]
       [description "A woman devoted to miricles but why is she here?"]
       [place *hospice*]
       [talk-line "The need for miracles is everywhere"]
       [item-talk-line "Why would you steal that from me? If you think you are going to leave this room alive think twice!"]
       [inventory'()]))
;location hospice, no item however trigger item-talk-line if stealing milk of the poppy without the coat




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;send commands
;(send *prison-cell* add-character *player*)
;(send *corridor* add-character *guard*)
;(send *courtyard* add-character *prisoner1*)
;(send *courtyard* add-character *prisoner2*)
;(send *prison-cell* add-adjacent-location! *corridor*)
;(send *corridor* add-adjacent-location! *prison-cell*)
;(send *corridor* add-adjacent-location! *basement*)
;(send *corridor* add-adjacent-location! *courtyard*)
;(send *courtyard* add-adjacent-location! *corridor*)
;(send *basement* add-adjacent-location! *corridor*)
;(send *player* add-item *old-key*)

