#lang racket
(require "character.rkt")
(require "place.rkt")
(require "world-init.rkt")
(require "interaction-utils.rkt")
(provide add-command! remove-command!
         valid-command? get-procedure
         get-valid-commands)

;; Module for storing and retrieving commands.
;; Provides
;;  - add-command! : symbol x procedure ->   
;;  - remove-command! : symbol -> 
;;  - valid-command? : symbol -> bool
;;  - get-procedure : symbol -> procedure

(define *commands* (make-hash))

;; Stores the procedure under name "cmd". This can
;; later be used in-game. cmd should be something like 'talk,
;; 'look or the like.
(define (add-command! cmd procedure)
  (hash-set! *commands* cmd procedure))

;; Removes a binding.
(define (remove-command! name)
  (hash-remove! *commands* name))

;; Tests if a command exists (otherwise retrieving the procedure
;; will fail).
(define (valid-command? name)
  (not (null? (filter (lambda (x)
                        (equal? name x))
                      (hash-keys *commands*)))))

;; Retrieves a procedure.
(define (get-procedure name)
  (hash-ref *commands* name))

;; Returns a list of all commands (eg (jump talk ...) ).
(define (get-valid-commands)
  (hash-keys *commands*))