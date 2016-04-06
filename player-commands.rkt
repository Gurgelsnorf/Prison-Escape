#lang racket

(require "cmd_store.rkt")
(require "character.rkt")
(require "place.rkt")
(require "world-init.rkt")

(provide (all-defined-out))

;;;;;;;;;;;;;;;;;;Player Commands;;;;;;;;;;;;;;;;;;;;;;;;;;;;




; help shows a list of all the possible player commands
(define (help-fn args)
  (printf "Valid commands: ~n")
  (for-each (lambda (x)
              (printf "~a ~n" x))
            (get-valid-commands)))
(add-command! 'help help-fn)


; look returns a list of adjacent locations
(define (look-fn args)
  (printf "~a ~n"
          (send (send *player* get-place)
                get-description)))
(add-command! 'look look-fn)


; inspect
(define (inspect-fn arg)
  (cond
    [(null? arg)
     (printf "Things possible to inspect: ~n")
     (for-each (lambda (x)
                 (printf "~a ~n" x))
               (append 
                (send (send *player* get-place) get-all-names)))]
    [(not (send (send *player* get-place) create-object-character (car arg)))
      (printf "You can't inspect ~a ~n" (car arg))]
    [else
     (print (send (send (send *player* get-place) create-object-character (car arg)) get-description))
     (newline)]))
(add-command! 'inspect inspect-fn)


; talk
(define (talk-fn arg)
  (cond
    [(null? arg)
     (printf "People you can talk to: ~n")
     (for-each (lambda (x)
                 (printf "~a ~n" x))
               (send (send *player* get-place) get-all-names))]
    [else
     (if (object? (send (send *player* get-place) create-object-character (car arg)))
         (begin (print (send (send (send *player* get-place) create-object-character (car arg)) talk))
                (newline))
         (printf "You can't talk to ~a ~n" (car arg)))]))
(add-command! 'talk talk-fn)

; move
(define (move-fn arg)
  (cond
    [(null? arg)
     (printf "You can move to: ~n")
     (for-each (lambda (x)
                 (printf "~a ~n" x))
               (map (lambda (x)
                      (send x get-name))
                    (send (send *player* get-place) list-of-adjacent-locations)))]
    [(not (send (send *player* get-place) create-object-location (car arg)))
     (printf "You can't move to ~a ~n" (car arg))]
    [else
     (send *player* move-to (send (send *player* get-place) create-object-location (car arg)))
     (printf "You arrive at the ~a ~n" (car arg))]))
(add-command! 'move move-fn)


;inventory 
(define (inventory-fn arg)
  (let ((player-inventory (send *player* get-inventory)))
    (cond
      [(null? arg)
       (if (null? player-inventory)
           (printf "Your inventory is empty ~n")
           (begin
             (printf "Inventory: ~n")
             (for-each (lambda (x)
                         (printf "~a ~n" x))
                       player-inventory)))]
      [(null? (send *player* get-inventory))
       (printf "You do not have: ~a ~n" (car arg))]
      [else
       (send (send *player* create-object-item (car arg)) get-description)])))
(add-command! 'inventory inventory-fn)
      
;BARA ETT TESTKOMANDO 
(define (jump-fn object)
  (printf "You jump and then land. ~n"))
(add-command! 'jump jump-fn)