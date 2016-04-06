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
    
    