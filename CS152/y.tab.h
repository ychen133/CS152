/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    IDENT = 259,
    FUNCTION = 260,
    BEGINPARAMS = 261,
    ENDPARAMS = 262,
    BEGINLOCALS = 263,
    ENDLOCALS = 264,
    BEGINBODY = 265,
    ENDBODY = 266,
    INTEGER = 267,
    ARRAY = 268,
    OF = 269,
    IF = 270,
    THEN = 271,
    ENDIF = 272,
    ELSE = 273,
    WHILE = 274,
    DO = 275,
    FOREACH = 276,
    IN = 277,
    BEGINLOOP = 278,
    ENDLOOP = 279,
    CONTINUE = 280,
    READ = 281,
    WRITE = 282,
    AND = 283,
    OR = 284,
    NOT = 285,
    TRUE = 286,
    FALSE = 287,
    RETURN = 288,
    SEMICOLON = 289,
    COLON = 290,
    COMMA = 291,
    L_PAREN = 292,
    R_PAREN = 293,
    L_SQUARE_BRACKET = 294,
    R_SQUARE_BRACKET = 295,
    ASSIGN = 296,
    EQ = 297,
    NEQ = 298,
    LT = 299,
    GT = 300,
    LTE = 301,
    GTE = 302,
    ADD = 303,
    SUB = 304,
    MULT = 305,
    DIV = 306,
    MOD = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 33 "mini_l.y" /* yacc.c:1909  */

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

#line 224 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
