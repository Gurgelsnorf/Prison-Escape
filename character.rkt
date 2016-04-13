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
                item-talk-line
                place
                inventory
                required-item
                event)

    (define/public (get-required-item)
      required-item)
    
    (define/public (add-required-item item)
      (set! required-item item))

    (define/public (get-event)
      event)
      
    (define/public (get-name)
      name)
    
    (define/public (get-description)
      description)
    
    (define/public (get-place)
      place)
    
    (define/public (talk)
      talk-line)

    (define/public (get-item-talk-line)
      item-talk-line)
    
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
        (set! inventory (cons item inventory))
        (send giver delete-item item)))

    (define/public (add-item item)
      (begin 
        (set! inventory (cons item inventory))))
    
    (define/public (delete-item item)
      (set! inventory (remove item inventory)))
    
            (define/public (create-object-item item-name)
      (let ((the-item (filter (lambda (x) 
                                (equal? item-name (send x get-name)))
                                inventory)))
        (if (null? the-item)
            '()
            (car the-item))))
    
    (super-new)))