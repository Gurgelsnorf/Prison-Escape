#lang racket

(require "cmd_store.rkt")
(require "character.rkt")
(require "place.rkt")
(require "world-init.rkt")

(provide (all-defined-out))

;;;;;;;;;;;;;;;;;;Player Commands;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; help - shows a list of all the possible player commands
(define (help-fn args)
  (printf "Valid commands: ~n")
  (for-each (lambda (x)
              (printf "* ~a ~n" x))
            (remove 'help (get-valid-commands))))
(add-command! 'help help-fn)


; look - returns a a description of the current location
(define (look-fn args)
  (printf "~a ~n"
          (send (send *player* get-place)
                get-description)))
(add-command! 'look look-fn)


; inspect - if called without an argument: returns a list of all the characters and items in the current location that you are able to inspect
;if called with an argumet: gives a description of the argument.
(define (inspect-fn arg)
  (let ([char-inspect (remove 'PLAYER (send (send *player* get-place) get-all-names))]
        [item-inspect (send (send *player* get-place) get-inventory)])
    (cond
      [(null? arg)
       (cond
         [(and (null? char-inspect) (null? item-inspect))
          (printf "There are no things to inspect in here ~n")]
         [(null? item-inspect)
          (printf "Characters in the ~a possible to inspect: ~n" (send (send *player* get-place) get-name))
          (for-each (lambda (x)
                      (printf "* ~a ~n" x))
                    char-inspect)]
         [(null? char-inspect)
          (printf "Items in the ~a possible to inspect: ~n" (send (send *player* get-place) get-name))
          (for-each (lambda (x)
                      (printf "* ~a ~n" x))
                    (map (lambda (x)
                           (send x get-name))
                         item-inspect))]
         [else
          (printf "Characters in the ~a possible to inspect:" (send (send *player* get-place) get-name))
          (newline)
          (for-each (lambda (x)
                      (printf "* ~a ~n" x))
                    char-inspect)
          (printf "Items in the ~a possible to inspect: ~n" (send (send *player* get-place) get-name))
          (for-each (lambda (x)
                      (printf "* ~a ~n" x))
                    (map (lambda (x)
                           (send x get-name))
                         item-inspect))])]
      [(null? (append
               (filter (lambda (x)
                         (equal? (car arg) x)) char-inspect)
               (filter (lambda (x)
                         (equal? (car arg) x)) (map (lambda (x)
                                                      (send x get-name))
                                                    item-inspect))))
       (printf "You can't inspect ~a ~n" (car arg))]
      [else
       (print (send
               (car (remove #f
                            (list
                             (send (send *player* get-place) create-object-character (car arg))
                             (send (send *player* get-place) create-object-item (car arg)))))
               get-description))
       (newline)])))
(add-command! 'inspect inspect-fn)




; talk - if called without an argument: gives back all the characters in the current location that you are able to talk with
; if called with an argument: displays the characters talkline
(define (talk-fn arg)
  (let ((char-to-talk (remove 'PLAYER (send (send *player* get-place) get-all-names))))
    (cond
      [(null? arg)
       (if (null? char-to-talk)
           (printf "There is no one here to talk with ~n")
           (begin
             (printf "People you can talk with: ~n")
             (for-each (lambda (x)
                         (printf "* ~a ~n" x))
                       char-to-talk)))]
      [(or (not (equal? 'with (car arg))) (null? (cdr arg)))
       (printf "Invalid input form. ~nCorrect input: talk with <character> ~n")]
      [else
       (if (object? (send (send *player* get-place) create-object-character (car (cdr arg))))
           (begin
             (printf "~a - " (send (send (send *player* get-place) create-object-character (car (cdr arg))) get-name))
             (print (send (send (send *player* get-place) create-object-character (car (cdr arg))) talk))
             (newline))
           (printf "You can't talk with ~a ~n" (car (cdr arg))))])))
(add-command! 'talk talk-fn)

; move - if called without an argument: returns a list with all the possible locations you can move to
; if called with an argument: moves to the prefered location
(define (move-fn arg)
  (cond
    [(null? arg)
     (if (null? (send (send *player* get-place) list-of-adjacent-locations))
         (printf "You can't move anywhere right now, the door is locked ~n")
         (begin
           (printf "You can move to: ~n")
           (for-each (lambda (x)
                       (printf "* ~a ~n" x))
                     (map (lambda (x)
                            (send x get-name))
                          (send (send *player* get-place) list-of-adjacent-locations)))))]
    [(or (not (equal? 'to (car arg))) (null? (cdr arg)))
     (printf "Invalid input form. ~nCorrect input: move to <location> ~n")]
    [(not (send (send *player* get-place) create-object-location (car (cdr arg))))
     (printf "You can't move to ~a ~n" (car (cdr arg)))]
    [else
     (send *player* move-to (send (send *player* get-place) create-object-location (car (cdr arg))))
     (printf "You arrive at the ~a ~n" (car (cdr arg)))]))
(add-command! 'move move-fn)


;inventory - if called without an argument: returns a list of all the items in your inventory
;if called with an argument: returns a description of a iem in the inventory
(define (inventory-fn arg)
  (let ((player-inventory (send *player* get-inventory)))
    (cond
      [(null? arg)
       (if (null? player-inventory)
           (printf "I don't have any itmes at the moment ~n")
           (begin
             (printf "Inventory: ~n")
             (for-each (lambda (x)
                         (printf "* ~a ~n" x))
                       (map (lambda (x)
                              (send x get-name))
                            player-inventory))))]
      [(null? (filter (lambda (x)
                        (equal? (car arg) x))
                      (map (lambda (x)
                             (send x get-name))
                           player-inventory)))                      
       (printf "I have no such item called ~a ~n" (car arg))]
      [else
       (printf "* ~a ~n"
               (send (send
                      *player*
                      create-object-item
                      (car (filter (lambda (x)
                                     (equal? (car arg) x))
                                   (map (lambda (x)
                                          (send x get-name))
                                        player-inventory))))
                     get-description))])))
(add-command! 'inventory inventory-fn)


;take - if called without an argument: returns a list of all the items in the current location that you are able to pick up
; if called with an argument: picks up an item and places it in your inventory
(define (take-fn arg)
  (let ((items-to-take (send (send *player* get-place) get-inventory)))
    (cond
      [(null? arg)
       (if (null? items-to-take)
           (printf "There are no items to pick up here ~n")
           (begin
             (printf "Things you can pick up:~n")
             (for-each (lambda (x)
                         (printf "* ~a ~n" x))
                       (map (lambda (x)
                              (send x get-name))
                            items-to-take))))]
      [(null? (filter (lambda (x)
                        (equal? (car arg) x))
                      (map (lambda (x)
                             (send x get-name))
                           items-to-take)))
       (printf "You can't pick up: ~a ~n" (car arg))]
      [else
       (send *player* receive (send (send *player* get-place)
                                    create-object-item
                                    (car (filter (lambda (x)
                                                   (equal? (car arg) x))
                                                 (map (lambda (x)
                                                        (send x get-name))
                                                      items-to-take))))
             (send *player* get-place))
       (printf "You picked up the ~a ~n" (car arg))])))
(add-command! 'take take-fn)


;give - if called without an argument: returns a list with all the items you can give away
; if called with an argument: removes an item from your inventory and places it in another character's

(define (give-fn arg)
  (let ((player-inventory (send *player* get-inventory)))
    (cond
      [(null? arg)
       (if (null? player-inventory)
           (printf "I don't have any items to give away ~n")
           (begin
             (printf "Items you can give away: ~n")
             (for-each (lambda (x)
                         (printf "* ~a ~n" x))
                       (map (lambda (x)
                              (send x get-name))
                            player-inventory))))]
      [(or (not (equal? 'the (car arg))) (not (equal? 'to (car (cddr arg)))) (null? (cdddr arg)) (null? (cddr arg)))
       (printf "Invalid input form. ~nCorrect input: give the <item> to <character> ~n")]
      [(null? (filter (lambda (x)
                        (equal? (car (cdr arg)) x))
                      (map (lambda (x)
                             (send x get-name))
                           player-inventory)))
       (printf "You can't give away ~a ~n" (car (cdr arg)))]
      [(null? (filter (lambda(x)
                        (equal? (car (cdddr arg)) x))
                      (remove 'PLAYER (send (send *player* get-place) get-all-names))))
       (printf "You can't give things to ~a ~n" (car (cdddr arg)))]
      [else
       (let ((the-character (send (send *player* get-place)
                                   create-object-character
                                   (car (filter (lambda (x)
                                                  (equal? (car (cdddr arg)) x))
                                                (send (send *player* get-place) get-all-names)))))
             (the-item (send *player*
                             create-object-item
                             (car (filter (lambda (x)
                                            (equal? (car (cdr arg)) x))
                                          (map (lambda (x)
                                                 (send x get-name))
                                               (send *player* get-inventory)))))))
         (if (equal? the-item (send the-character get-required-item))
             (begin
               (send the-character receive the-item *player*)
               (printf "You gave the ~a to ~a ~n ~n" (car (cdr arg)) (car (cdddr arg)))
               (printf "~a - " (car (cdddr arg)))
               (printf "~a ~n" (send the-character get-item-talk-line))
               ((send the-character get-event)))
             (printf "~a does not have any use for that ~n" (send the-character get-name))))])))
(add-command! 'give give-fn)






;Use - takes one special-item and uses it on another special-item

(define (use-fn arg)
  (let ((player-inventory (send *player* get-inventory))
        (special-items (send (send *player* get-plae) get-special-inventory)))
    (cond
      [(null? arg)
       (cond
         [(null? player-inventory)
          (printf "I don't have any items to use right now ~n")]
         [(null? special-items)
          (printf "There are no items in here that i can use ~n")]
         [else
          (printf "Items in your inventory you can use: ~n")
          (for-each (lambda (x)
                      (printf "~a ~n" x)) player-inventory)
          (printf "Items you can use you things on: ~n")
          (for-each (lambda (x)
                      (printf "~a ~n" x)) special-items)])]
      [(or (not (equal? 'on (car (cdr arg)))) (null? (cddr arg)))
       (printf "Invalid input form ~n")
       (printf "Correct input: use <item in inventory> on <item in location> ~n")]
      [(or (null? (filter (lambda (x)
                            (equal? (car arg) x))
                          (player-inventory)))
           (null? (filter (lambda (x)
                            (equal? (car (cddr arg)) x))
                          special-items)))
       (printf "You can't use that ~n")]
      [else
       (let ((item1 (send *player* create-object-item
                          (car (filter (lambda (x)
                                         (equal? (car arg) x))
                                       (map (lambda (x)
                                              (send x get-name))
                                            (send *player* get-inventory))))))
              (item2 (send (send *player* get-place) create-object-special-item
                          (car (filter (lambda (x)
                                         (equal? (car (cddr arg)) x))
                                       (map (lambda (x)
                                              (send x get-name))
                                            (send (send *player* get-place) get-special-inventory)))))))
         (if (equal? item1 (send item2 get-required-item))
             (begin
               (printf "You successfully used the ~a on the ~a ~n" (send item1 get-name) (send item2 get-name))
               (send item2 get-evet))
             (printf "You can't use the ~a on the ~a ~n" (send item1 get-name) (send item2 get-name))))])))
