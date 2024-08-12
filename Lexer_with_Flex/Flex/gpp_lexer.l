/***
Lexer with Flex
Kağan Çakıroğlu
CSE 341 Programming Languages
***/




/*** Definition Section has one variable
which can be accessed inside yylex()
and main() ***/

/*Definition*/
%{
	#include <stdio.h>
	#include <string.h>
	const char* define_op(char*);
	const char*
	const char* make_upper(char*);
	const char* generate_error(char*);
	int error(char*);
	//static void skip_single_line_comment(void);

	int c_OP = 0;	
	const char* eat_string(void);
	int x=0;
%}

DIGIT [0-9]

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

OPERATORS [+-/*(),]

KEYWORD 	and|or|not|equal|less|nil|list|append|concat|set|deffun|for|if|exit|load|disp|true|false 

VALUEI   	"0"|[1-9]{DIGIT}*

VALUEF 	 	{DIGIT}*"f"{DIGIT}+

STRING 	 	\".*\"

INVSTRING	["][a-zA-Z0-9_]+|[a-zA-Z0-9_]+["]

/*RULES*/
%%

";;".*					{ printf("%s:\n", yytext);}


{KEYWORD} 				{ printf("%s:KW_%s\n", yytext, make_upper(yytext)); }

{OPERATORS} 			{ printf("%s:OP_%s\n", yytext, define_op(yytext));}

"**"					{ printf("%s:OP_DBLMULT\n", yytext);}

{IDENTIFIER}			{ printf("%s:IDENTIFIER\n", yytext);}

{VALUEF}				{ printf("%s:VALUEF\n", yytext);}

{VALUEI}				{ printf("%s:VALUEI\n", yytext);}

{STRING}				{ printf("OP_OC\nVALUESTR\nOP_CC\n");}

"\n"	  					{ /* newline */}

[0][0-9]+  				{printf("LEXICAL ERROR - %s: VALUEI can not start with 0\n", yytext); 
								return 0;}
[0][a-zA-Z]+			{printf("LEXICAL ERROR - %s: IDENTIFIER can not start with 0\n", yytext);
								return 0;}
{INVSTRING}				{printf("LEXICAL ERROR - %s: STRING can not left open\n", yytext);
								return 0;}

[ \t\n]+					{;}

.							{error("error");}
%%

const char* define_op(char* op){
		
			if(!strcmp(op,"+"))
			{
				return "PLUS";
			}
			else if(!strcmp(op,"-"))
			{
				return	"MINUS";
			}
			else if(!strcmp(op,"/"))
			{
				return "DIV";
			}
			else if(!strcmp(op,"*"))
			{
				return "MULT";
			}
			else if(!strcmp(op,"("))
			{
				return "OP";
			}
			else if(!strcmp(op,")"))
			{
				return "CP";
			}
			else if(!strcmp(op,","))
			{
				return "COMMA";
			}
			else
			{
				return	"unrecognized";
			}
			
}

const char* define_key(char* key){
		
			if(!strcmp(op,"+"))
			{
				return "PLUS";
			}
			else if(!strcmp(op,"-"))
			{
				return	"MINUS";
			}
			else if(!strcmp(op,"/"))
			{
				return "DIV";
			}
			else if(!strcmp(op,"*"))
			{
				return "MULT";
			}
			else if(!strcmp(op,"("))
			{
				return "OP";
			}
			else if(!strcmp(op,")"))
			{
				return "CP";
			}
			else if(!strcmp(op,","))
			{
				return "COMMA";
			}
			else
			{
				return	"unrecognized";
			}
			
}

const char* make_upper(char* op){
	int i;
	for (i = 0; op[i]!='\0'; i++) 
	{
      if(op[i] >= 'a' && op[i] <= 'z') {
         op[i] = op[i] - 32;
      }
   	}
   	return op;
}

int error(char *emg)
{
	printf("Syntax-error!\n");
	exit(0);
}


/*** Code section prints the number of capital letter present in the given input ***/

int yywrap(){}

int main(int argc, char *filename[]){
	


	// To take input from file
	FILE *fn;
	fn = fopen(filename[1],"r");
	yyin = fn;

	yylex();

	fclose(yyin);
	return 0;
}

