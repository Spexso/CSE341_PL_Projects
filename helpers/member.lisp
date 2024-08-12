(defun is-member(lst item)
	(cond 
		((= (car lst) nil) nil)
		((= (car lst) item) t)
		(t (is-member (cdr lst) item))
	)
)

(print (is-member '(1 234 456 456 4) 78))