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

%left '+' '-'
%left '*' '/'
%right KW_THEN KW_ELSE

%union{
	struct hash* symbol;
}


%%

program: 
	|function_def program
	|global_var_def_list program

function_def: type identifier '(' param ')' local_var_def_list '{' simple_commands_list '}'

function_call: identifier '(' arg ')'

arg: 
		|identifier arg_rest

arg_rest: 
		| ',' identifier arg_rest


simple_commands_list: 
		|simple_command ';' simple_commands_list

no_comma_commands_list: 
		|simple_command no_comma_commands_list

simple_command: atrib
		|flux_control 
		|input 
		|output 
		|return 

atrib: identifier '=' expression
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

output: KW_OUTPUT LIT_STRING out_rest
	|KW_OUTPUT aritm_exp out_rest

out_rest:',' LIT_STRING
	|',' aritm_exp 
	|',' LIT_STRING out_rest
	|',' aritm_exp out_rest

return: KW_RETURN expression

aritm_exp: 	LIT_INTEGER 
		|SYMBOL_LIT_FLOATING
		|LIT_INTEGER  aritm_operator aritm_exp
		|SYMBOL_LIT_FLOATING aritm_operator aritm_exp

flux_control: KW_IF '('expression')' KW_THEN no_comma_commands_list KW_ELSE no_comma_commands_list
		|KW_IF '('expression')' KW_THEN no_comma_commands_list
		|KW_LOOP '(' no_comma_commands_list ',' expression ',' no_comma_commands_list ')' no_comma_commands_list



int_expression: LIT_INTEGER
		|LIT_INTEGER aritm_operator int_expression

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

global_var_def_list: global_var_def
		|global_var_def global_var_def_list

global_var_def: type identifier ':' value ';'
		|type '$'identifier ':' value ';'
		|type identifier '[' LIT_INTEGER ']' ':' lit_seq ';'		
		|type identifier '[' LIT_INTEGER ']'';'

lit_seq: LIT_INTEGER lit_seq_empty
	|LIT_FALSE lit_seq_empty
	|LIT_TRUE lit_seq_empty  
	|LIT_CHAR lit_seq_empty  
	|LIT_STRING lit_seq_empty  
 
lit_seq_empty:
	|LIT_INTEGER lit_seq_empty
	|LIT_FALSE lit_seq_empty
	|LIT_TRUE lit_seq_empty  
	|LIT_CHAR lit_seq_empty  
	|LIT_STRING lit_seq_empty


type: 	KW_WORD				
	| KW_BOOL			
	| KW_BYTE			

identifier: TK_IDENTIFIER		

value:	LIT_INTEGER 
	|LIT_FALSE 
	|LIT_TRUE	  		
	|LIT_CHAR   			
	|LIT_STRING			



%%

int main()
{

	exit (yyparse());

}

yyerror(s) char *s; {
       fprintf( stderr, "Syntax error. Linha: %i\n", getLineNumber() );
	exit(3);
       }
