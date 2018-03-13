/* cs-152-winter2018
 * Phase 1 Project: Lexical scanner
 * Yu-Che Cheng 
 * SID:861142301
*/

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"
	int currLine = 1, currPos = 1;
	int identifying = 0;
%}

DIGIT	[0-9]
ALPHA	[a-zA-Z]
UNDERSCORE	[_]	

%%
	/*Reserved Words*/
"function"     	{currPos += yyleng; return FUNCTION;}
"beginparams"  	{currPos += yyleng; return BEGINPARAMS;}
"endparams"     {currPos += yyleng; return ENDPARAMS;}
"beginlocals"   {currPos += yyleng; return BEGINLOCALS;}
"endlocals"     {currPos += yyleng; return ENDLOCALS;}
"beginbody"     {currPos += yyleng; return BEGINBODY;}
"endbody"   	{currPos += yyleng; return ENDBODY;}
"integer"   	{currPos += yyleng; return INTEGER;}
"array"     	{currPos += yyleng; return ARRAY;}
"of"     	{currPos += yyleng; return OF;}
"if"     	{currPos += yyleng; return IF;}
"then"     	{currPos += yyleng; return THEN;}
"endif"     	{currPos += yyleng; return ENDIF;}
"else"     	{currPos += yyleng; return ELSE;}
"while"     	{currPos += yyleng; return WHILE;}
"do"     	{currPos += yyleng; return DO;}
"foreach"     	{currPos += yyleng; return FOREACH;}
"in"     	{currPos += yyleng; return IN;}
"beginloop"     {currPos += yyleng; return BEGINLOOP;}
"endloop"     	{currPos += yyleng; return ENDLOOP;}
"continue"     	{currPos += yyleng; return CONTINUE;}
"read"     	{currPos += yyleng; return READ;}
"write"     	{currPos += yyleng; return WRITE;}
"and"     	{currPos += yyleng; return AND;}
"or"     	{currPos += yyleng; return OR;}
"not"     	{currPos += yyleng; return NOT;}
"true"     	{currPos += yyleng; return TRUE;}
"false"     	{currPos += yyleng; return FALSE;}
"return"     	{currPos += yyleng; return RETURN;}
	/*ArithmeticOperators*/  
"-"	{currPos += yyleng; return SUB;}
"+"     {currPos += yyleng; return ADD;}
"*"     {currPos += yyleng; return MULT;}
"/"     {currPos += yyleng; return DIV;}
"%"     {currPos += yyleng; return MOD;}
	/*ComparisonOperators*/ 
"=="     {currPos += yyleng; return EQ;}
"<>"     {currPos += yyleng; return NEQ;}
"<"    	 {currPos += yyleng; return LT;}
">"      {currPos += yyleng; return GT;}
"<="     {currPos += yyleng; return LTE;}
">="     {currPos += yyleng; return GTE;}
	/*Identifiers and Numbers*/
({ALPHA})(({ALPHA}|{DIGIT}|{UNDERSCORE})*({ALPHA}|{DIGIT})+)*	{yylval.string = yytext; currPos += yyleng; return IDENT;}
({DIGIT})+	{yylval.integer = atof(yytext); currPos += yyleng; return NUMBER;}
({DIGIT}|{UNDERSCORE})({ALPHA}|{DIGIT}|{UNDERSCORE})+		{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}
({ALPHA})(({ALPHA}|{DIGIT}|{UNDERSCORE})*({UNDERSCORE}))		{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);}
	/*OtherSpecialSymbols*/ 
";"    	{currPos += yyleng; return SEMICOLON;}
":"     {currPos += yyleng; return COLON;}
","     {currPos += yyleng; return COMMA;}
"("     {currPos += yyleng; return L_PAREN;}
")"     {currPos += yyleng; return R_PAREN;}
"["     {currPos += yyleng; return L_SQUARE_BRACKET;}
"]"     {currPos += yyleng; return R_SQUARE_BRACKET;}
":="    {currPos += yyleng; return ASSIGN;}

[ \t]+	{/*ignore spaces*/ currPos += yyleng;}
"\n"	{currLine++; currPos = 1;}
.	{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%


