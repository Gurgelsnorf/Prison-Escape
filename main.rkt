#lang racket

(require "interaction-utils.rkt")
(require "cmd_store.rkt")
(require "character.rkt")
(require "place.rkt")
(require "player-commands.rkt")
(require "world-init.rkt")




;;;;;;;;;;;;;;;;;;;INPUT LOOP;;;;;;;;;;;;;;;;;;;;;

(define (interaction-loop)
  (printf ">> ")
  (enter-new-command!)
  (let
      ([name (get-command-name)]
       [args (get-command-arguments)])
    (cond
      [(or (eq? name 'quit) (eof-object? name))
       (display "Bye! Thanks for playing!")]
      [(not (valid-command? name))
       (printf "It's not possible to ~a ~n" name)
       (interaction-loop)]
      [else
       ((get-procedure name) args)
       (if (= game-over 0)
           (interaction-loop)
           (printf "Thanks for playing! ~n"))])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; play-game starts the game and gives the player an introduction to the story
(define (play-game)
  (printf "Welcome to Prison Escape! ~n ~n *To play the game, simply write what your want you character to do. ~n *For a list of possible commands, enter help. ~n~n A general example of how to use most commands: ~n   give -> shows a list of all the items you're able give away and all the characters you're able to give them to ~n   give Key to Guard -> gives the Key to the Guard~n
~n Enjoy the game! ~n ~n You find yourself in a cold prison cell. ~n How did you even get here? ~n You must get out! ~n")
  (interaction-loop))