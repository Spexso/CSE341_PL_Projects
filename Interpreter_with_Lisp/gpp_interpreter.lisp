

"and" 
  "or" 
  "not" 
  "eq" 
  "gt" 
  "nil" 
  "set"

(defvar Keywords (list 
   "deffun" "if" "exit" "defvar" "true" "false")
                  )
(defvar KW (list "KW_DEFF" "KW_IF" "KW_WHILE" "KW_EXIT" "KW_DEFV" "KW_DISP" "KW_TRUE" "KW_FALSE"))
(defvar Operator (list "+" "-" "/" "*" "(" ")" "and" "or" "," "not" "eq" "gt" "nil" "set"))
(defvar OP (list "OP_PLUS" "OP_MINUS" "OP_DIV" "OP_OP" "OP_MULT" "OP_CP" "OP_COMMA" "OP_AND" "OP_OR" "OP_NOT" "OP_SET" "OP_GT" "OP_EQ"))
(defvar Comment ";")
(defvar Possible (list "(" ")" "\""))
(defvar tokens (list))
(defvar tokensLine (list))
(defvar sym (list))
(defvar symValue (list))

(defun evaluateLine (line)
 (let ((blocks) (result 0) (tempWord) (flag 0))
  (setf tokensLine (list))
  (setf tokens (list))
  (setf line (string-trim '(#\Space #\Tab #\Newline) line))
  (setf blocks (split-str line))
  (loop for blockq in blocks
   do
   (progn
    (setf tempWord (string-trim '(#\Space #\Tab #\Newline) blockq))
    (setf result (WordSlash tempWord))
    (if (or (equal result 2) (equal result -1)) (return result))))
  (if (equal result -1)
   (write "SYNTAX_ERROR ")
   (progn
    (if (equal result 2) ()
     (progn
      (setf flag (evaluate))
      (if (equal flag nil) (setf flag ()))
      (if (equal flag nil) (write "SYNTAX_ERROR "))))))result))

(defun WordSlash(c))

(defun evaluate (&optional(tempTokens tokens) (tempTokensLine tokensLine)(flag2 0))
      )


(defun convertList (tempTokens tempTokensLine)
 (let ((len (list-length tempTokens)) (kw) (result 1) (val1) (llist (list)))
  (if (and (string= (nth 0 tempTokensLine) "OP_OP") (string= (nth (- len 1) tempTokensLine) "OP_CP") (> len 2))
   (progn
    (loop for i from 1 to (- len 2)
     do(progn
       (setf kw (nth i tempTokensLine))
       (if (string= kw "VAL")
        (setf val1 (list (parse-integer (nth i tempTokens))))
        (if (string= kw "ID") (setf val1 (findId (nth i tempTokens))) (setf result nil)))
       (if (not (equal result nil)) (setf llist (append llist val1)))))
    (if (not (equal result nil)) (setf result llist)))(setf result nil))result))

(defun isVal (blockq)
 (let ((char) (result t))
  (if (equal (every #'digit-char-p blockq) nil)
   (setf result nil)
   (progn
    (if (= (length blockq) 1)
     (setf result t)
     (progn
      (setf char (char blockq 0))
      (if (equal (digit-char-p char) 0) (setf result nil) (setf result t))))))
  result))

(defun split-str (string &optional (separator " "))
 (split-Q string separator))


(defun split-Q (string &optional (separator " ") (r nil))
 (let ((n (position separator string
   :from-end t
   :test #'(lambda (x y)
     (find y x :test #'string=)))))
  (if n
 (split-Q (subseq string 0 n) separator (cons (subseq string (1+ n)) r))
 (cons string r))))

(defun gppinterpreter (&optional filename)
  (let ((line) (flag))
   (loop
     (format t "> ")
     (setf line (read-line))
     (when (string= line "") (return))
     (setf flag (evaluateLine line))
     (terpri)
  (when (= flag -1) (return))))
)
      
(if *args* (gppinterpreter (car *args*)) (gppinterpreter))