#lang racket
(provide character%)


; name: the characters name
; description: a brief description of the character
; place: where the character is located (stores the obejct, not only the name of the place)
; talk-line: what the character says
; inventory: a LIST of the items the carried by the charcter

(define character%
  (class object%
    (init-field name
                description
                talk-line
                place
                inventory)
   
    
    (define/public (get-name)
      name)
    
    (define/public (get-description)
      description)
    
    (define/public (get-place)
      place)
    
    (define/public (talk)
      talk-line)
    
    (define/public (get-inventory)
      (cond [(null? inventory)
             '()]
            [else
             inventory]))
    
    (define/public (move-to new-place)
      (send new-place add-character this)
      (send place delete-character (send this get-name))
      (set! place new-place))
 
    
    (define/public (receive item giver)
      (begin 
        (cons item inventory)
        (send giver delete-item item)))
    
    (define/public (delete-item item)
      (set! inventory (remove item inventory)))
    
            (define/public (create-object-item item-name)
      (let ((the-item (filter (lambda (x) 
                                (equal? item-name (send x get-name)))
                                inventory)))
        (if (null? the-item)
            #f
            (car the-item))))
    
    (super-new)))