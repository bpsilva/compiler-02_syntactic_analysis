%{
#include<stdlib.h>
#include<stdio.h>

%}

%token KW_WORD  
%token KW_BOOL      
%token KW_BYTE    
%token KW_IF       
%token KW_THEN      
%token KW_ELSE     
%token KW_LOOP   
%token KW_INPUT  
%token KW_RETURN   
%token KW_OUTPUT 

%token OPERATOR_LE 
%token OPERATOR_GE 
%token OPERATOR_EQ 
%token OPERATOR_NE
%token OPERATOR_AND
%token OPERATOR_OR 

%token TK_IDENTIFIER
%token LIT_INTEGER 
%token LIT_FALSE 
%token LIT_TRUE	  
%token LIT_CHAR   
%token LIT_STRING  

%token TOKEN_ERROR 


%token SYMBOL_UNDEFINED 0
%token SYMBOL_LIT_INTEGER 1
%token SYMBOL_LIT_FLOATING 2
%token SYMBOL_LIT_TRUE 3
%token SYMBOL_LIT_FALSE 4
%token SYMBOL_LIT_CHAR 5
%token SYMBOL_LIT_STRING 6 
%token SYMBOL_IDENTIFIER 7

%%


command: var ',' var
var: '*'		 {printf("var\n");}


%%

int main()
{
	return (yyparse());

}

yyerror(s) char *s; {
       fprintf( stderr, "%s\n", s );
       }
