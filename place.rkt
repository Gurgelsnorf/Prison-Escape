#lang racket
(provide place%)
(require "character.rkt")
(require "item.rkt")

; name: the name of the place
; description: a brief description of the place and what you can find in it
; characters-in-place: a LIST of the characters (as objects) in the place
; inventory: a LIST of all the items in the place

(define place%
  (class object%
    (init-field name
                description
                [adjacent-locations '()]
                [characters-in-place '()]
                [inventory '()]
                [special-inventory '()])

    (define/public (get-special-inventory)
      special-inventory)

    (define/public (add-special-item item)
      (set! special-inventory (cons item special-inventory)))

    (define/public (create-object-special-item item-name)
      (let ((the-item (filter (lambda (x) 
                                (equal? item-name (send x get-name)))
                              special-inventory)))
        (if (null? the-item)
            '()
            (car the-item))))
    
    (define/public (get-name)
      name)
    
    (define/public (get-description)
      description)
    
    (define/public (list-of-adjacent-locations)
          adjacent-locations)
    
       
    (define/public (add-adjacent-location! location)
      (set! adjacent-locations 
            (cons location 
                  adjacent-locations)))

    (define/public (get-place-object place-name)
      (if (equal? name place-name)
          this
          #f))
      
      
    (define/public (add-character character)
      (set! characters-in-place (cons character characters-in-place)))
    
    (define/public (create-object-character character-name)
      (let ((the-char (filter (lambda (x) 
                                (equal? character-name (send x get-name)))
                                characters-in-place)))
        (if (null? the-char)
            '()
            (car the-char))))
    
    (define/public (delete-character character-name)
      (set! characters-in-place (remove
                                 (send this create-object-character character-name)
                                 characters-in-place)))
    
    (define/public (characters)
      (if (null? characters-in-place)
          '()
          characters-in-place))
    
    (define/public (get-all-names)
      (map (lambda (x)
             (send x get-name))
           characters-in-place))
    
    (define/public (create-object-location location-name)
      (let ((the-place (filter (lambda (x) 
                                (equal? location-name (send x get-name)))
                                adjacent-locations)))
        (if (null? the-place)
            '()
            (car the-place))))
    
    
    (define/public (get-inventory)
      (cond [(null? inventory)
             '()]
            [else
             inventory]))

    (define/public (add-item item)
        (set! inventory (cons item inventory)))
    
    
    (define/public (receive item giver)
      (begin 
        (set! inventory (cons item inventory))
        (send giver delete-item item)))
    
    
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