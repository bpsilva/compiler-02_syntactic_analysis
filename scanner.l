%{
// Bruno Pinto Silva Cartão: 217446 bpsilva


#define TRUE 1
#define FALSE 0
#include<string.h>
#include "y.tab.h"

int isRunning();
int getLineNumber();
int yywrap();

int lineNumber = 1;
int running = TRUE;
%}

%x COMMENT

%%

word		 		{return KW_WORD;}
bool 				{return KW_BOOL;}
byte				{return KW_BYTE;}
if				{return KW_IF;}
then				{return KW_THEN;}
else				{return KW_ELSE;}
loop				{return KW_LOOP;}
input				{return KW_INPUT;}
return				{return KW_RETURN;}
output				{return KW_OUTPUT;}
[-,;:(){}+*/<>=!&$]		{return yytext[0];}
"["				{return yytext[0];}
"]"				{return yytext[0];}
"<="				{return OPERATOR_LE;}
">="				{return OPERATOR_GE;}
"=="				{return OPERATOR_EQ;}
"!="				{return OPERATOR_NE;}
"&&"				{return OPERATOR_AND;}
"||"				{return OPERATOR_OR;}
"\n"				{lineNumber++;}
[0-9]+"."[0-9]+			{insert(yytext,  LIT_FLOATING);return  LIT_FLOATING;}
[0-9]+ 				{insert(yytext,  LIT_INTEGER);return LIT_INTEGER;}
FALSE				{insert(yytext,  LIT_FALSE);return LIT_FALSE;}
TRUE				{insert(yytext,  LIT_TRUE);return LIT_TRUE;}
[A-Za-z_][A-Za-z_0-9]*		{insert(yytext,  TK_IDENTIFIER);return TK_IDENTIFIER;}
"'"."'" 			{insert(yytext,  LIT_CHAR);return LIT_CHAR;}
["].*["]			{insert(yytext,  LIT_STRING);return LIT_STRING;}
" "
"//".*
"/*"				BEGIN(COMMENT);
<COMMENT>\n			{lineNumber++;}
<COMMENT>.	
<COMMENT>"*/"			BEGIN(INITIAL);
[0-9]+[A-Za-z_]+[A-Za-z_0-9]*	{return TOKEN_ERROR;}
. 				{return TOKEN_ERROR;}

%%



int isRunning(){ return running;}
int getLineNumber(){return lineNumber;}
int yywrap(){running = FALSE; return 1;}
