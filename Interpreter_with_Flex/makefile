interpreter: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o interpreter

lex.yy.c: y.tab.c gpp_lexer_yacc.l
	lex gpp_lexer_yacc.l

y.tab.c: gpp_interpreter.y
	yacc -d gpp_interpreter.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h interpreter interpreter.dSYM
