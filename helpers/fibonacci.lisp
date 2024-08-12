(defun fibonacci (n)
  "compute for the Nth fibonacci number"
  (if (or (zerop n) (= n 1))
    1 
    (let ((F1 (fibonacci (- n 1)))
         (F2  (fibonacci (- n 2))))
          (+ F1 F2))))

(print (fibonacci 12))