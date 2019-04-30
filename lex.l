%{

#include <string.h>
#include "types.h"
#include "y.tab.h"

%}

%option noyywrap

%%

"@"                     { return SYM_AMPERSAND; }
"{"                     { return BRACE_OPEN; }
"}"                     { return BRACE_CLOSE; }
"="                     { return SYM_EQUAL; }
","                     { return SYM_COMMA; }
"\""                    { return QUOTES; }
[a-zA-Z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\‘\|]+ {
                          strcpy(yylval.sval, yytext); return IDENTIFIER; }
[.\n]                   { /* ignore */ }

%%
