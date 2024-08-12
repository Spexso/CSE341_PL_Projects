(defconstant pi 3.141592)

(defun area-circle(rad)
	(terpri)
	(format t "Radius = ~d~%" rad)
	(setq n(* (* rad rad) pi))
	(format t "Area of circle = ~d~%" n)
)

(area-circle 10)