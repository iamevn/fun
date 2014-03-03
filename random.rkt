#lang racket
(require racket/draw)

(define x-res 900)
(define y-res 900)
(define target (make-bitmap x-res y-res))
(define dc (new bitmap-dc% [bitmap target]))

;set smoothing for drawing
(send dc set-smoothing 'aligned)

;set up black background
(send dc set-brush "black" 'solid)
(send dc draw-rectangle 0 0 x-res y-res)

;a random color with a random transparency
(define (rand-color)
  (make-object color% (random 255) (random 255) (random 255) (random)))

;draw count random lines
(define (random-lines count)
  (let loop ([i 0])
    (cond [(= i count) target]
          [else
           (send dc set-pen (rand-color) 2 'solid)
           (send dc draw-line
                 (add1 (random (sub1 x-res)))
                 (add1 (random (sub1 y-res)))
                 (add1 (random (sub1 x-res)))
                 (add1 (random (sub1 y-res))))
           (loop (add1 i))])))

;draw count random rectangles
(define (random-rects count)
  (let loop  ([i 0])
    (cond [(= i count) target]
          [else
           (let ([chosen-color (rand-color)])
             (send dc set-pen chosen-color 1 'solid)
             (send dc set-brush chosen-color 'solid)
             (send dc draw-rectangle
                   (add1 (random (- (* 2 (sub1 x-res)) (quotient (sub1 x-res) 2))))
                   (add1 (random (- (* 2 (sub1 y-res)) (quotient (sub1 y-res) 2))))
                   (add1 (random (sub1 x-res)))
                   (add1 (random (sub1 y-res))))
             (loop (add1 i)))])))


(define (save-to-file filename)
  (send target save-file (string-append filename ".png") 'png))