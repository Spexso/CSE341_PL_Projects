(defun equal-simple (lst1 lst2)
	(cond
		((eq lst1 nil) (eq lst2 nil))
		((eq lst2 nil) nil)
		((eq (car lst1) (car lst2)) (equal-simple (cdr lst1) (cdr lst2)))
		(t nil)	
	)
)

(write (equal-simple '(123) '(123 5)))