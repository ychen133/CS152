/* mini_l.y */

%{
//C Declarations
#include <stdio.h>
#include <stdlib.h>
#include <map>
#include <iostream>
#include <sstream>
#include <string>
#include <stack>
#include <vector>
using namespace std;
int yylex(void);
void yyerror(const char *msg);
extern int currLine;
extern int currPos;
bool Err = false;
int t = 0, p = 0, l = 0; 
//FILE * yyin;
static int val = 0;
string ErrorMsg = "";
map<string, int> Symbols;
stack<string> Idents;

static const string KeyWords[] = 	{"_program", "_endprogram", "_array", "_if", "_endif", "_while", "_beginloop", "_continue", "_write", "_or", "_true", "_begin_program", "_integer", "_of", "_then",
					"_else", "_do", "_endloop", "_read", "_and", "_not", "_false"};

vector<string> KeywordsVector (KeyWords, KeyWords + sizeof(KeyWords) / sizeof(KeyWords[0]));

%}

%union{
	//char* sval;	//string value
	char* string;

	//int ival;	//integer value
	int integer;

	struct
	{

	} program;

	struct
	{

	} function;

	struct
	{
		string id;
		string code;
	} funct;

	struct 
	{

	} declaration;

	struct
	{
	} declarate;

	struct
	{
	} array;
		
	struct
	{
	} ident;

	struct
	{
	} statement;

	struct
	{
	} state;
		
	struct
	{
	} statement_end;

	struct
	{
	} bool_expr;

	struct
	{
	} relation_and_expr;

	struct
	{
	} relation_expr;

	struct
	{
	} comp;

	struct
	{
	} expression;

	struct 
	{
	} add_or_sub;

	struct
	{
	} multiplicative_expr;

	struct
	{
	} mult_div_mod;

	struct
	{
	} term;

	struct
	{
	} term1;

	struct
	{
	} term1a;

	struct 
	{
	} term2;

	struct
	{
	} expression_loop;

	struct
	{
	} var;
	
	struct
	{
	} identifier;

	struct
	{
	} var_loop;
}
	
/*Bison Declarations, all terminal symbols go in here*/
%error-verbose
%start program
%token <integer> NUMBER
%token <string> IDENT
%type <program> program
%type <function> function
%type <funct> funct
%type <declaration> declaration
%type <declarate> declarate
%type <array> array
%type <ident> ident
%type <statement> statement
%type <state> state
%type <statement_end> statement_end
%type <bool_expr> bool_expr
%type <relation_and_expr> relation_and_expr
%type <relation_expr> relation_expr
%type <comp> comp
%type <expression> expression
%type <add_or_sub> add_or_sub
%type <multiplicative_expr> multiplicative_expr
%type <mult_div_mod> mult_div_mod
%type <term> term
%type <term1> term1
%type <term1a> term1a
%type <term2> term2
%type <expression_loop> expression_loop
%type <var> var
%type <identifier> identifier
%type <var_loop> var_loop
%token FUNCTION BEGINPARAMS ENDPARAMS BEGINLOCALS ENDLOCALS BEGINBODY ENDBODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO FOREACH IN BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN EQ NEQ LT GT LTE GTE ADD SUB MULT DIV MOD

/*%left AND OR NOT EQ NEQ LT GT LTE GTE ADD SUB MULT DIV MOD*/

/*Grammar Rules*/
%%
program:	function 
		;
 
function:	/* epsilon */
		| funct function
		;

funct: 		FUNCTION IDENT SEMICOLON BEGINPARAMS declaration ENDPARAMS BEGINLOCALS declaration ENDLOCALS BEGINBODY statement ENDBODY 
		{
			//fname funct;
			//funct.id = string($2);
				
			string id = "_" + string($2);	//get the IDENT of the function
			int size = KeywordsVector.size();
			bool pass = true;
			for(int i = 0; i < size; i++)
			{
				if(id == KeyWords[i])
					pass = false;
			} 
			if(!pass)
			{
				ErrorMsg = "Error: " + id + " has been defined as a keyword and cannot be used";
				yyerror(ErrorMsg.c_str());
			}
			else
			{
				id = string($2);
				cout << "func " + id  << endl;
				cout << "funct.id = " + funct.id << endl;
			}
		}
		;

declaration:	/* epsilon */
		| declarate SEMICOLON declaration 
		;

declarate:	ident COLON array 
		{
				
		} 
		;

array:		INTEGER	
		{
			//printf(".\s", temp1);
		}
		| ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
		;

ident:		IDENT	
		{
			//temp1 = string($1);
			string id = string($1);
			//tmp_function(id);
		//string id = string($1);
		//if(Idents.find(id) == Idents.last)	//if id was not declared before, push to Ident
		//{
		//	Idents.push(id);
		//}
		//else					//if id was declared before, output error
		//{
		//	err_msg = "Error: " + id + " is multiply defined!";
		//	yyerror(err_msgid = str.c_str());
		//}
		}
		| IDENT COMMA ident 	
		;

statement:	state SEMICOLON 
		| state SEMICOLON statement 
		;

state:		var ASSIGN expression	
		| IF bool_expr THEN statement statement_end	
		| WHILE bool_expr BEGINLOOP statement ENDLOOP	
		| DO BEGINLOOP statement ENDLOOP WHILE bool_expr	
		| FOREACH IDENT IN IDENT BEGINLOOP statement ENDLOOP	
		| READ var_loop		
		| WRITE var_loop	
		| CONTINUE		
		| RETURN expression	
		;

statement_end:	ENDIF	
		| ELSE statement ENDIF	
		;
 
bool_expr:	relation_and_expr			
		| relation_and_expr OR bool_expr	
		;

relation_and_expr:	relation_expr 				
			| relation_expr AND relation_and_expr 	
			;	

relation_expr:	relation_expressions		
		| NOT relation_expressions	
		;

relation_expressions:	expression comp expression	
			| TRUE				
			| FALSE				
			| L_PAREN bool_expr R_PAREN	
			;	

comp:	EQ	
	| NEQ	
	| LT	
	| GT	
	| LTE	
	| GTE	
	;

expression:	multiplicative_expr				
		| multiplicative_expr add_or_sub expression	
		;

add_or_sub:	ADD	
		| SUB	
		;

multiplicative_expr:	term					
			| term mult_div_mod multiplicative_expr	
			;

mult_div_mod:	MULT	
		| DIV	
		| MOD	
		;	

term:		term1			
		| IDENT L_PAREN term2 	
		;

term1:	SUB term1a	
	| term1a	
	;

term1a:	var				
	| NUMBER			
	| L_PAREN expression R_PAREN	
	;

term2: 	expression_loop R_PAREN	
	| R_PAREN		
	;

expression_loop:	expression				
			| expression COMMA expression_loop	
			; 

var:		identifier							
		| identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET	
		;

identifier: IDENT	{
	string ident = string($1);

}

var_loop:	var COMMA		
		| var COMMA var_loop
		;		
%%

void yyerror(const char *msg) {
   	//printf("** Line %d, position %d: %s\n", currLine, currPos, msg);
	printf("** Line %d %s\n", currLine, msg);
}

void tmp_function(string id) {
	Symbols.insert(pair<string, int>(id, val));
	val++;
}

int main(int argc, char **argv){
	if(argc > 1)
	{
		if(freopen(argv[1], "r", stdin) == NULL)
		{
			printf("syntax: %s filename\n", argv[0]);
		}
	}
	yyparse();
	return 0;
}

/*
int main(int argc, char **argv) {
	if (argc > 1) {
		yyin = fopen(argv[1], "r");
		if (yyin == NULL){
         		printf("syntax: %s filename\n", argv[0]);
			exit(1);
		}
	}

	yyparse();
	return 0;
}
*/

/*
void yyerror(const char *msg) {
   printf("** Line %d, position %d: %s\n", currLine, currPos, msg);
}*/

/*
int yyerror(string s)
{
	extern int yylineno;
	extern char *yytext;
	cerr << "ERROR: " << s << " at symbol \"" << yytext;
	cerr << "\" on line " << yylineno << endl;
	exit(1);
}

int yyerror(char *s)
{
	return yyerror(string (s));
}
*/






