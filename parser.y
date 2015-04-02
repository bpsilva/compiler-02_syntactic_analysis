%{
#include<stdlib.h>
#include<stdio.h>
#include"hash.h"
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

%token TOKEN_ERROR 

%union
{
	struct hash* symbol;
	int n;
}


%token SYMBOL_UNDEFINED 0
%token  SYMBOL_LIT_INTEGER 1
%token  SYMBOL_LIT_FLOATING 2
%token  SYMBOL_LIT_TRUE 3
%token  SYMBOL_LIT_FALSE 4
%token SYMBOL_LIT_CHAR 5
%token SYMBOL_LIT_STRING 6 
%token  SYMBOL_IDENTIFIER 7

%left '+' '-'
%left '*' '/'
%right KW_THEN KW_ELSE




%%

program: 
	|function_def program
	|global_var_def program
	;

global_var_def: type identifier ':' value ';'
		|type '$'identifier ':' value ';'
		|type identifier '[' SYMBOL_LIT_INTEGER ']' ':' SYMBOL_LIT_seq ';'		
		|type identifier '[' SYMBOL_LIT_INTEGER ']'';'


function_def: type identifier '(' param ')' local_var_def_list '{' simple_commands_list '}'

function_call: identifier '(' arg ')'

arg: 
	|identifier arg_rest
	|SYMBOL_LIT_INTEGER arg_rest
	|SYMBOL_LIT_FALSE arg_rest
	|SYMBOL_LIT_TRUE arg_rest
	|SYMBOL_LIT_CHAR arg_rest
	|SYMBOL_LIT_STRING arg_rest


arg_rest: 
		| ',' identifier arg_rest
		|',' SYMBOL_LIT_INTEGER arg_rest
		|',' SYMBOL_LIT_FALSE arg_rest
		|',' SYMBOL_LIT_TRUE arg_rest
		|',' SYMBOL_LIT_CHAR arg_rest
		|',' SYMBOL_LIT_STRING arg_rest


simple_commands_list: 
		|simple_command ';' simple_commands_list

simple_command: atrib
		|flux_control 
		|input 
		|output 
		|return 

atrib: '+''+'identifier
	|identifier '+''+'
	|identifier '=' expression
	| identifier '[' expression ']' '=' expression

expression: identifier '[' int_expression ']' expression_rest
	|identifier expression_rest
	|value expression_rest 
	|function_call expression_rest 
	|'&'identifier expression_rest 
	|'$'identifier expression_rest 

expression_rest: 
	|op expression


input: KW_INPUT identifier

output: KW_OUTPUT SYMBOL_LIT_STRING out_rest
	|KW_OUTPUT aritm_exp out_rest

out_rest:
	|',' SYMBOL_LIT_STRING out_rest
	|',' aritm_exp out_rest ;

return: KW_RETURN expression

aritm_exp: 	SYMBOL_LIT_INTEGER 
		|SYMBOL_LIT_FLOATING
		|SYMBOL_LIT_INTEGER  aritm_operator aritm_exp
		|SYMBOL_LIT_FLOATING aritm_operator aritm_exp

flux_control: KW_IF '('expression')' then
		|KW_LOOP '(' simple_command ';' expression ';' simple_command ')' '{'simple_commands_list'}'

then: KW_THEN '{'simple_commands_list'}'  else
	|KW_THEN   simple_command	else

else: 
	|KW_ELSE '{'simple_commands_list'}'
	|KW_ELSE  simple_command


int_expression: SYMBOL_LIT_INTEGER
		|SYMBOL_LIT_INTEGER aritm_operator int_expression

op: bool_operator
	|aritm_operator

bool_operator: '>'
		|'<'
	
aritm_operator: '+'
		|'-'
		|'*'
		|'/'

local_var_def_list: 
		|local_var_def local_var_def_list

local_var_def: type identifier ':' value ';' 
		|type '$'identifier ':' value ';'

param: 
		|type identifier paramseq

paramseq: 
		| ',' type identifier paramseq


SYMBOL_LIT_seq: SYMBOL_LIT_INTEGER SYMBOL_LIT_seq_empty
	|SYMBOL_LIT_FALSE SYMBOL_LIT_seq_empty
	|SYMBOL_LIT_TRUE SYMBOL_LIT_seq_empty  
	|SYMBOL_LIT_CHAR SYMBOL_LIT_seq_empty  
	|SYMBOL_LIT_STRING SYMBOL_LIT_seq_empty  
 
SYMBOL_LIT_seq_empty:
	|SYMBOL_LIT_INTEGER SYMBOL_LIT_seq_empty
	|SYMBOL_LIT_FALSE SYMBOL_LIT_seq_empty
	|SYMBOL_LIT_TRUE SYMBOL_LIT_seq_empty  
	|SYMBOL_LIT_CHAR SYMBOL_LIT_seq_empty  
	|SYMBOL_LIT_STRING SYMBOL_LIT_seq_empty


type: 	KW_WORD				
	| KW_BOOL			
	| KW_BYTE			

identifier: SYMBOL_IDENTIFIER		

value:	SYMBOL_LIT_INTEGER 
	|SYMBOL_LIT_FALSE 
	|SYMBOL_LIT_TRUE	  		
	|SYMBOL_LIT_CHAR   			
	|SYMBOL_LIT_STRING			



%%

int main()
{

	exit (yyparse());

}

yyerror(s) char *s; {
       fprintf( stderr, "Syntax error. Linha: %i\n", getLineNumber() );
	exit(3);
       }
