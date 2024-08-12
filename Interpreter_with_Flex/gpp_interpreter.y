%{

void yyerror ();
int yylex();

#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
			struct block
			{
				float val;
				char n[10];
			};
			
int count = 0;						/* For identifiers */
int countf = 0;						/* For functions */

struct block myIDs[100];			/* List of identifiers */
struct block myFs[100];				/* List of functions   */

double getVal(char[]);
double updateVal(char[], int);

double getValf(char[], int);

%}

/* Yacc definitions */

%union {

			struct
			{
				char* name;
				int num; 
				double numf;
				int bool;
			};
		
		}         


%start START


%token DEFV
%token DEFF
%token KW_WHILE
%token KW_IF
%token KW_EXIT
%token <bool> KW_TRUE
%token <bool> KW_FALSE

%token COMMENT

%token OP_PLUS            
%token OP_MINUS
%token OP_DIV
%token OP_MULT
%token OP_OP
%token OP_CP
%token OP_SET
%token OP_COMMA
%token OP_AND
%token OP_OR
%token OP_NOT
%token OP_EQ
%token OP_GT

%token <name> ID
%token <numf> VALUEF

%type <numf> EXP EXPLIST FUNCTION FCALL
%type <numf> ASG
%type <bool> EXPB


%%
/* Translation of BNF expressions */

START   : 
		| START INPUT 		
		;

INPUT   : EXP 																	{ printf("%f\n", $1);}
		| FUNCTION																{ printf("%f\n", $1);}
		| EXPLIST																{ printf("%f\n", $1);}
		;

EXPLIST : OP_OP EXPLIST EXP OP_CP												{ printf("%f\n", $3);}
		| EXP
		;

FUNCTION : OP_OP DEFF ID OP_OP EXPLIST OP_CP OP_CP								{ 
																				myFs[countf].val = $5;
																				strcpy(myIDs[countf].n, $3);
																				/* printf("AL %d", get($3)); */
																				countf++;
																				}
		;

EXP     : OP_OP KW_EXIT OP_CP													{ exit(EXIT_SUCCESS);} 
		| OP_OP DEFV ID EXP OP_CP												{ 
																				myIDs[count].val = $4;
																				strcpy(myIDs[count].n, $3);
																				/* printf("AL %d", get($3)); */
																				count++;
																				}
		| OP_OP OP_PLUS EXP EXP OP_CP											{ $$ = $3 + $4; }
		| OP_OP OP_MINUS EXP EXP OP_CP											{ $$ = $3 - $4; }
		| OP_OP OP_MULT EXP EXP OP_CP											{ $$ = $3 * $4; }
		| OP_OP OP_DIV EXP EXP OP_CP											{ $$ = $3 / $4; }
		/*
		| OP_OP OP_SET ID EXP OP_CP												{ $$ = $4;}
		| OP_OP KW_IF EXPB EXPLIST OP_CP										{
																				  $$ = opr(IF, $3, $4);
		 																		}
		| OP_OP KW_WHILE EXPB EXPLIST EXPLIST OP_CP								{
																				  $$ = opr(WHILE, $3, $4, $5);
		 																		}
		*/
		| ASG																	{ $$ = $1; /*printf("ASG here and %d\n", $$)*/;}
		| ID 																	{ /* printf("Identifier here and %s\n", $1) */;}
		| VALUEF																{ $$ = $1; /*printf("ValueF here and %d \n", $$)*/;}
		| FCALL																	{ $$ = $1;}
		| EXPB																	{ $$ = $1;}
		;

ASG		: OP_OP OP_SET ID EXP OP_CP												{ updateVal($3, $4);}
		;


FCALL   : OP_OP ID EXP OP_CP 													{ $$ = getValf($2, $3);}
		;

EXPB	: OP_OP OP_EQ EXP EXP OP_CP 											{
																					if( $3 == $4)
																					{
																						$$ = 1;
																					}
																					else
																					{
																						$$ = 0;
																					}
																				}
		| OP_OP OP_GT EXP EXP OP_CP												{
																					if( $3 > $4)
																					{
																						$$ = 1;
																					}
																					else
																					{
																						$$ = 0;
																					}
																				}
		| OP_OP OP_AND EXPB EXPB OP_CP											{
																					if( $3 && $4)
																					{
																						$$ = 1;
																					}
																					else
																					{
																						$$ = 0;
																					}
																				}
		| OP_OP OP_OR EXPB EXPB OP_CP											{
																					if( $3 | $4)
																					{
																						$$ = 1;
																					}
																					else
																					{
																						$$ = 0;
																					}
																				}
		| OP_OP OP_NOT EXPB OP_CP												{
																					if(!$3)
																					{
																						$$ = 1;
																					}
																					else
																					{
																						$$ = 0;
																					}
																				}
		| KW_TRUE 																{
																					$$ = 1;
																				}
		| KW_FALSE																{
																					$$ = 0;
																				}
		;

%%                     

/* C code */


double getVal(char k[10])
{
	for(int i=0; i < 100; i++)
	{
		if(!strcmp(myIDs[i].n, k))
		{
			return myIDs[i].val;
		}
	}
}

double updateVal(char k[10], int new_val)
{
	for(int i=0; i < 100; i++)
	{
		if(!strcmp(myIDs[i].n, k))
		{
			myIDs[i].val = new_val;
		}
	}
}

double getValf(char k[10], int callV)
{
	for(int i=0; i < 100; i++)
	{
		if(!strcmp(myFs[i].n, k))
		{
			myFs[i].val = callV;
			return myFs[i].val;
		}
	}
}


int main () 
{
	return yyparse ( );
}

void yyerror () 
{
	printf ("Syntax Error!");
	exit(1);
}