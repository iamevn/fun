#lang racket
;plot sierpinski triangle in R3 (aka: tetrix) using chaos game

(require plot)
(require plot/utils)
(require racket/vector)

(plot-new-window? #t)
(plot-foreground (->color 'white))
(plot-background (->color 'black))

;number of points to filter out of the start of the generated list
(define filter-cnt 13)
;number of points to generate
(define num-points 100000)

(struct colored-point (posn color) #:transparent)
(struct plane (point normal) #:transparent)

(define corners
  (list (colored-point (vector 0 0 0) (->color 'red))
        (colored-point (vector 1 0 0) (->color 'green))
        (colored-point (vector .5 (/ (sqrt 3) 2) 0) (->color 'blue))
        (colored-point (vector .5 (/ (sqrt 3) 4) 1) (->color 'purple))))

(define (random-corner)
  (colored-point-posn (list-ref corners (random (length corners)))))

(define (midpoint vec-a vec-b)
  (v/ (v+ vec-a vec-b) 2))

;simple weight function, uses distance from a to b
(define (vect-weight a b)
  (abs (- 1 (sqrt (+ (expt (- (vector-ref a 0) (vector-ref b 0)) 2)
                     (expt (- (vector-ref a 1) (vector-ref b 1)) 2)
                     (expt (- (vector-ref a 2) (vector-ref b 2)) 2))))))

;slower but better weight function, uses ratio of distance from p to corner / length of line that passes from corner through p and intersects with the opposite face of the shape
(define (better-vect-weight p corner)
  (let ([point-vector (transform p corner)])
    (- 1 (/ (vmag point-vector)
            (vect-intersect-length point-vector (opposite-face corner))))))

;plane opposite of a corner, defined by 3 points in corner-space
(define (opposite-face-points corner)
  (remove (vector 0 0 0) (map (λ (struct-elem)
                                (transform (colored-point-posn struct-elem) corner))
                              corners)
          v=)) ;comparison method for remove

;takes a plane defined by 3 points and returns normal
(define (normal points)
  (vcross (transform (second points) (first points))
          (transform (third points) (first points))))

;returns plane structure
(define (opposite-face corner)
  (let ([points (opposite-face-points corner)])
    (plane (car points) (normal points))))

;finds intersection between a vector and a plane
(define (vect-intersect-length vect plane)
  (let ([normal (plane-normal plane)])
    (/ (vdot (plane-point plane) (plane-normal plane))
       (vdot vect (plane-normal plane)))))

;transform coordinate system to be centered at new-origin
(define (transform point new-origin)
  (v- point new-origin))

;chaos game
(define (new-color-point previous)
  (let ([new-point (midpoint (colored-point-posn previous) (random-corner))])
    (colored-point new-point (point->color new-point))))

;returns a color tuple based on position of a point
(define (point->color point-vec)
  (->color (foldl (λ (init weighted-color)
                    (map (λ (prev elem)
                           (+ prev elem))
                         init weighted-color))
                  '(0 0 0)
                  ;weighted color for each corner
                  (map (λ (weight color)
                         (map (λ (a) (* weight a))
                              color))
                       ;list of weights from each corner
                       (map (λ (corner) (better-vect-weight point-vec (colored-point-posn corner)))
                            corners)
                       ;list of colors for each corner
                       (map (λ (corner) (colored-point-color corner))
                            corners)))))

;a list of points with colors
(define colored-point-list
  (let loop ([count 1]
             [previous (colored-point (vector (random) (random) (random)) '(0 0 0))])
    (if (> count (+ filter-cnt num-points)) '()
        (cons previous (loop (add1 count)
                             (new-color-point previous))))))

;list of points with first filter elements dropped
(define filtered-point-list
 (list-tail colored-point-list filter-cnt))

;plot n points from generated list
(define (plot-n-points n)
  (plot3d (map (λ (vec)
               (points3d (list (colored-point-posn vec)) #:color (colored-point-color vec) #:fill-color 'black #:sym 'dot))
             (take filtered-point-list n))))