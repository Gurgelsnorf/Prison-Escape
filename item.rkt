#lang racket
(provide item%)



(define item%
  (class object%
    (init-field
     name
     description)
    
    (define/public (get-name)
      name)
    
    (define/public (get-description)
      description)
  (super-new)))


(define special-item%
  (class item%
    (init-field
     required-item
     event)

    (define/public (get-event)
      event)

    (define/public (get-required-item)
      required-item)
    (super-new)))
    