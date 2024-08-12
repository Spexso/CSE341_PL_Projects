;Lexer in Lisp
;							Kağan Çakıroğlu 
;							CSE341 Programming Languages

;Keywords
(defparameter KW_AND "and")
(defparameter KW_OR "or")
(defparameter KW_NOT "not")
(defparameter KW_EQUAL "equal")
(defparameter KW_LESS "less")
(defparameter KW_NIL "nil")
(defparameter KW_LIST "list")
(defparameter KW_APPEND "append")
(defparameter KW_CONCAT "concat")
(defparameter KW_SET "set")
(defparameter KW_DEFFUN "deffun")
(defparameter KW_FOR "for")
(defparameter KW_IF "if")
(defparameter KW_EXIT "exit")
(defparameter KW_LOAD "load")
(defparameter KW_DISP "disp")
(defparameter KW_TRUE "true")
(defparameter KW_FALSE "false")

;Operators
(defparameter OP_PLUS "+")
(defparameter OP_MINUS "-")
(defparameter OP_DIV "/")
(defparameter OP_MULT "*")
(defparameter OP_OP "(")
(defparameter OP_CP ")")
(defparameter OP_DBLMULT "**")
(defvar OP_STR " ")												;GOTTA LOOK HERE LATER 
(defparameter OP_COMMA ",")

;Required variables
(defparameter word "")
(defparameter word_check "")

;Comment
(defparameter COMMENT ";")

;File name
(defparameter file_n "test1")

;identifier
(setq char-ide nil)



(defun gppinterpreter(filename &key (as-strings nil))
	
	(cond 
	
	(
			(string-equal file_n nil)
			(format t "Invalid file name~%")
	)
	(
		(string-equal file_n "test1")
		(format t "Test has found~%")
	)

	)
	
	(with-open-file (in file_n :if-does-not-exist nil)
		(when in 
		(loop for char = (read-char in nil)
				while char do 
				(cond
					((and (eq (alpha-char-p char) T) (eq char-ide nil)
					(setq char-ide 1)))

					((and (eq (alpha-char-p char) nil) (eq char-ide nil) 
					(setq char-ide 2)))
				)
				
				(setq word (concatenate 'string word (string char)))
				
				(cond 
					((char= char #\SPACE) 
					;(format t "SPACE HERE~%")
					(word_definer))
					
					((char= char #\linefeed) 
					(word_definer))
										
				)
				)
			)
		)
		
)
           


(defun word_definer()
		(write-line word)
		(cond
			;((and (string= (subseq word 0 2) COMMENT) (string= word "") 
			;(format t "~A -> COMMENT" word)))
			
		)
		(parser_kw)
		(setq word "")
		;(setq char-ide nil)
)


(defun parser_op()
	(cond
					((string= (string char) OP_PLUS)
					(format t "(~A) -> ~S~%" 'char 'OP_PLUS))

					((string= (string char) OP_MINUS)
					(format t "(~A) -> ~S~%" 'char 'OP_MINUS))

					((string= (string char) OP_DIV)
					(format t "(~A) -> ~S~%" 'char 'OP_DIV))

					((string= (string char) OP_MULT)
					(format t "(~A) -> ~S~%" 'char 'OP_MULT))

					((string= (string char) OP_OP)
					(format t "(~A) -> ~S~%" 'char 'OP_OP))

					((string= (string char) OP_CP)
					(format t "(~A) -> ~S~%" 'char 'OP_CP))

					((string= (string char) OP_DBLMULT)
					(format t "(~A) -> ~S~%" 'char 'OP_DBLMULT))

					((string= (string char) OP_COMMA)
					(format t "(~A) -> ~S~%" 'char 'OP_COMMA))

				)
	)

(defun parser_kw()
	(cond
					((string= (string word) KW_AND)
					(format t "(~A) -> ~S~%" word 'KW_AND))

					((string= (string word) KW_OR)
					(format t "(~A) -> ~S~%" word 'KW_OR))

					((string= (string word) KW_NOT)
					(format t "(~A) -> ~S~%" word KW_NOT))

					((string= (string word) KW_EQUAL)
					(format t "(~A) -> ~S~%" 'word 'KW_EQUAL))

					((string= (string word) KW_LESS)
					(format t "(~A) -> ~S~%" 'word 'KW_LESS))

					((string= (string word) KW_NIL)
					(format t "(~A) -> ~S~%" 'word 'KW_NIL))

					((string= (string word) KW_LIST )
					(format t "(~A) -> ~S~%" word 'KW_LIST ))

					((string= (string word) KW_APPEND)
					(format t "(~A) -> ~S~%" word 'KW_APPEND))

					((string= (string word) KW_CONCAT)
					(format t "(~A) -> ~S~%" word 'KW_CONCAT))

					((string= (string word) KW_SET )
					(format t "(~A) -> ~S~%" word 'KW_SET ))

					((string= (string word) KW_DEFFUN)
					(format t "(~A) -> ~S~%" word 'KW_DEFFUN))

					((string= (string word) KW_FOR)
					(format t "(~A) -> ~S~%" word 'KW_FOR))

					((string= (string word) KW_IF)
					(format t "(~A) -> ~S~%" word 'KW_IF))

					((string= (string word) KW_EXIT)
					(format t "(~A) -> ~S~%" word 'KW_EXIT))

					((string= (string word) KW_LOAD)
					(format t "(~A) -> ~S~%" word 'KW_LOAD))

					((string= (string word) KW_DISP)
					(format t "(~A) -> ~S~%" word 'KW_DISP))

					((string= (string word) KW_TRUE)
					(format t "(~A) -> ~S~%" word 'KW_TRUE))

					((string= (string word) KW_FALSE)
					(format t "(~A) -> ~S~%" word 'KW_FALSE))

				)
	)



(gppinterpreter file_n)