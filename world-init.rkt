#lang racket

(require "item.rkt")
(require "character.rkt")
(require "place.rkt")
(provide (all-defined-out))


;;;;;;;;;;Events;;;;;;;;;;;;

(define (felkin-event)
  (send *player* recieve *chesters-long-coat* *felkin*))

(define (gavlan-event)
  (send *player* recieve *lucatiels-mask* *gavlan*))

(define (lucatiel-event)
  (send *player* recieve *storage-key* *lucatiel*))

(define (box-event)
  (set! guard-post 0)
  (printf "This is sure to get the guard away from their posts ~n"))

(define (liquor-spike)
  (send *storage* add-item *spiked-liquor*)
  (printf "There we go this liquor more than effective ~n"))

(define (cell-door-event)
  (send *prison-cell* add-adjacent-location! *corridor*)
  (printf "The cell door clicks and with a slight creaking sound opens up ~n"))

(define (storage-door-event)
  (send *courtyard* add-adjacent-location! *storage*)
  (printf "A slight stench of mold comes escapes as the door opens and also a hissing sound probably from a torch. The sound of dripping water can aslo be heard ~n"))

(define (asylum-door-event)
  (if (= 0 guard-post)
      (begin
        (send *courtyard* add-adjacent-location! *escape*)
        (printf "Few things beets the feeling of freedom ~n"))
      (begin
        (printf "You did not manage to escape. The guards are still on their posts and saw everything. ~n Game over ~n")
        (set! game-over 1))))
  
;ITEMS


(define *old-key*
  (new item%
       [name 'Old-key]
       [description "An old key that is compleatly worn out, still it might have some use none the less."]))
;in prison cell used to pick door

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

(define *dark-orb*
  (new item%
       [name 'Dark-orb]
       [description "A hex modified from an old sorcery by Gilleah, the father of Hexing."]))
;found in hospice

(define *chesters-long-coat*
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

(define *spiked-liquor*
  (new item%
       [name 'Spiked-liquor]
       [description "A liquor that actually can knock someone out before they relise what is going on"]))
       
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

;;;;;;;;;;;;;;;;;;;Special-item;;;;;;;;;;;;;;;;;;;

(define *cell-door*
  (new special-item%
       [name 'Cell-door]
       [description "This door keeps me in here"]
       [required-item *old-key*]
       [event cell-door-event]))

(define *asylum-door*
  (new special-item%
       [name 'Asylum-door]
       [description "This giant door and the guards guarding it keeps keeps me locked in here till the end of my days if I don't do anything about it"]
       [required-item *asylum-key*]
       [event asylum-door-event]))

(define *stack-of-boxes*
  (new special-item%
       [name 'Stack-of-boxes]
       [description "An assortment of boxes and other rubble, a wonder the torch hasn't set this on fire yet"]
       [required-item *torch*]
       [event box-event]))

(define *liquor*
  (new special-item%
       [name 'Liquor]
       [description "Gives of a strong smell of alcohol making it impossible to detect any other smell or proabably any other tastes also for that matter"]
       [required-item *milk-of-the-poppy*]
       [event liquor-spike]))
;in storage used on guard door (with milk of the poppy in inventory) do frug the guard for the key


;;;;;;;;;;;;;;;;;;;CHARACTERS;;;;;;;;;;;;;;;;;;;;;


(define *player*
  (new character%
       [name 'PLAYER]
       [description "You"]
       [place *prison-cell*]
       [talk-line "tjoho!"]
       [item-talk-line "Det här ska ine kunnas visas"]
       [inventory '()]
       [required-item 'nope]
       [event 'nope]))

(define *guard-pate*
  (new character%
       [name 'Guard-Pate]
       [description "A lazy guard only looking out for himself"]
       [place *corridor*]
       [talk-line "If you think you are ever leaving that cell you have the wrong idea of this place, and I will not need to watch you starve I have wealth that needs aquiering."]
       [item-talk-line '()]
       [inventory '()]
       [required-item 'nope]
       [event 'nope]))
;location prison cell keeps you from leaving until you have talked to him

(define *lucatiel*
  (new character%
       [name 'Lucatiel]
       [description "Lucatiel was one a proud night of Mirrah and now wonders the land of Drangleic due to a curse she is hesitant to talk about."]
       [place *courtyard*]
       [talk-line "My name is Lucatiel and I come from the land of Mirrah. Don't mind the hollowing it is just the curse, on that note if you ever get your hand on my mask from Gavlan i would be more than pleased."]
       [item-talk-line "Thank you for keeping my sanity, take this key it might bring you more fortune than it did for me and please rememember my name for I might not."]
       [inventory '()]
       [required-item *lucatiels-mask*]
       [event lucatiel-event]))
;location burial has the storage key

(define *gavlan*
  (new character%
       [name 'Gavlan]
       [description "A short man probably related to the Gyrms, however he seems only interested in wheeling and dealing"]
       [place *courtyard*]
       [talk-line "Who you? I Gavlan. Gavlan wheel? Gavlan deal. Gavlan want soul. Many many soul. Gah hah! What you want? With Gavlan, you wheel? You deal! Gah hah!"]
       [item-talk-line "Many deal...Many thanks! Gah hah!"]
       [inventory '()]
       [required-item *lesser-soul*]
       [event gavlan-event]))

;location courtyard, item Lucatiel's Mask

(define *felkin*
  (new character%
       [name 'Felkin]
       [description "The darkness shrouding Felkin is unnerving to the very core, none the less he might have valuable information but information is not free"]
       [place *dark-cell*]
       [talk-line "Unless you can prove that you are not afraid of embracing rhe dark we have nothing to talk about."]
       [item-talk-line "I see that you are not a person of bigotry judging before knowing anything, take the Chester's Long Coat it will help you embrace the dark and move in silence."]
       [inventory '()]
       [required-item *dark-orb*]
       [event felkin-event]))
;location dark-cell, item Chester's-long-coat

(define *licia*
  (new character%
       [name 'Licia]
       [description "A woman devoted to miricles but why is she here?"]
       [place *hospice*]
       [talk-line "The need for miracles is everywhere"]
       [item-talk-line "Why would you steal that from me? If you think you are going to leave this room alive think twice!"]
       [inventory '()]
       [required-item 'nope]
       [event 'nope]))
;location hospice, no item however trigger item-talk-line if stealing milk of the poppy without the coat


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Item sends from start
(send *felkin* add-item *chesters-long-coat*)
(send *gavlan* add-item *lucatiels-mask*)
(send *lucatiel* add-item *storage-key*)
(send *prison-cell* add-item *old-key*)
(send *burial* add-item *lesser-soul*)
(send *storage* add-item *torch*)
(send *hospice* add-item *dark-orb*)

;special-item
(send *prison-cell* add-special-item *cell-door*)
(send *courtyard* add-special-item *courtyard*)
(send *storage* add-special-item *stack-of-boxes*)
(send *storage* add-special-item *liquor*)

;Adjlocations
(send *corridor* add-adjacent-location! *prison-cell*)
(send *corridor* add-adjacent-location! *dark-cell*)
(send *corridor* add-adjacent-location! *courtyard*)
(send *courtyard* add-adjacent-location! *corridor*)
(send *courtyard* add-adjacent-location! *burial*)
(send *courtyard* add-adjacent-location! *hospice*)
(send *burial* add-adjacent-location! *courtyard*)
(send *dark-cell* add-adjacent-location! *corridor*)
(send *storage* add-adjacent-location! *courtyard*)
(send *hospice* add-adjacent-location! *courtyard*)

;Characters
(send *prison-cell* add-character *player*)
(send *dark-cell* add-character *felkin*)
(send *courtyard* add-character *gavlan*)
(send *burial* add-character *lucatiel*)
(send *prison-cell* add-character *guard-pate*)
(send *hospice* add-character *licia*)



;;;;;;;;;;;;;;;;;;;;;;;
;Global variables
(define guard-post 1)
(define game-over 0)
