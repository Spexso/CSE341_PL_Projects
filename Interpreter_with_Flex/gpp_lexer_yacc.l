/*Definitions*/
%{

#include "y.tab.h"
void error(char*);
int yylex();
int elect_key(char* keyw);
int elect_op(char* op);

%}

DIGIT			[0-9]+

NUMBER 		[0]|[1-9][0-9]*

IDENTIFIER 	[a-zA-Z_][a-zA-Z0-9_]*

OPERATORS 	[+-/*(),]

KEYWORD 		exit|defvar|deffun|while|if|true|false 

VALUEF 	 	{DIGIT}*"f"{DIGIT}

COMMENT 		[;][;][a-zA-Z0-9\/.+-]+


%%

"exit"					{
								return KW_EXIT;
							}

{KEYWORD} 				{
								printf("\nReturning KEYWORD\n");
								return elect_key(yytext); 
							}

{OPERATORS}				{
								/* printf("\nReturning OPERATOR\n"); */
								return elect_op(yytext);
							}

{COMMENT}				{
								return COMMENT;
							}


{IDENTIFIER}			{
								/* printf("\nReturning ID\n"); */
								yylval.name = strdup(yytext); 
								return ID;
							}

{VALUEF}					{
								/* printf("\nReturning VALUEF %s\n", yytext); */
								int i=0;
								while(yytext[i] !='\0')
								{
									if(yytext[i] == 'f')
									{
										yytext[i] = '.';
									}
									i++;
								}
								/* printf("NOw - %s\n", yytext); */
								yylval.numf = atof(yytext);
								return VALUEF;
							}


[ \t\n]+             {;}


.                    {error("Syntax-Error!\n");}

%%

int elect_key(char* keyw){
		
			if(!strcmp(keyw,"defvar"))
			{
				return DEFV;
			}
			else if(!strcmp(keyw,"deffun"))
			{
				/* printf(" deffun "); */
				return DEFF;
			}
			else if(!strcmp(keyw,"while"))
			{
				return KW_WHILE;
			}
			else if(!strcmp(keyw,"if"))
			{
				return KW_IF;
			}
			else if(!strcmp(keyw,"true"))
			{
				return KW_TRUE;
			}
			else if(!strcmp(keyw,"false"))
			{
				return KW_FALSE;
			}
			
}

int elect_op(char* op){
		
			if(!strcmp(op,"+"))
			{
				/* printf(" plus ");*/
				return OP_PLUS;
			}
			else if(!strcmp(op,"-"))
			{
				/* printf(" minus "); */
				return OP_MINUS;
			}
			else if(!strcmp(op,"/"))
			{
				/* printf(" DIV "); */
				return OP_DIV;
			}
			else if(!strcmp(op,"*"))
			{
				/* printf(" mult "); */
				return OP_MULT;
			}
			else if(!strcmp(op,"("))
			{
				/* printf(" open \n"); */
				return OP_OP;
			}
			else if(!strcmp(op,")"))
			{
				/* printf(" close \n"); */
				return OP_CP;
			}
			else if(!strcmp(op,"set"))
			{
				/* printf(" set "); */
				return OP_SET;
			}
			else if(!strcmp(op,","))
			{
				/* printf(" comma "); */
				return OP_COMMA;
			}
			else if(!strcmp(op,"and"))
			{
				/* printf(" & "); */
				return OP_AND;
			}
			else if(!strcmp(op,"or"))
			{
				/* printf(" | "); */
				return OP_OR;
			}
			else if(!strcmp(op,"not"))
			{
				/* printf(" ! "); */
				return OP_NOT;
			}
			else if(!strcmp(op,"eq"))
			{
				/* printf(" equal "); */
				return OP_EQ;
			}
			else if(!strcmp(op,"gt"))
			{
				/* printf(" > "); */
				return OP_GT;
			}
			
}


void error(char *emg){
	
	printf("%s", emg);
	exit(0);
}


int yywrap (void) {return 1;}

