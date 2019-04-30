%{

#include <stdio.h>
#include <string.h>
#include "types.h"
#include "util.h"

extern int yylex();
extern int yyerror (char *);

/* takes care of the size of the array containing fields */
int size = 0;

%}

%union {
    int         ival;
    char        sval[10000];
    Entry       entry_val;
    Field       field_val;
    Field       field_list[10];
};

%token  <ival>          SYM_AMPERSAND SYM_COMMA SYM_EQUAL
%token  <ival>          BRACE_OPEN BRACE_CLOSE QUOTES
%token  <sval>          IDENTIFIER

%type   <sval>          name key string string_all
%type   <field_val>     field
%type   <field_list>    fields
%type   <entry_val>     entry


%%

bibtex:         /* nothing */
                    {   /* nothing */
                    }
                | entry bibtex
                    {   entry_show($1);
                        free($1.name);
                        free($1.key);
                    }
                ;

entry:          SYM_AMPERSAND name BRACE_OPEN key SYM_COMMA fields BRACE_CLOSE
                    {   $$.name   = strdup($2);
                        $$.key    = strdup($4);
                        for (int i = 0; i < size; i++) {
                            strcpy($$.fields[i].name, $6[i].name);
                            strcpy($$.fields[i].value, $6[i].value);
                        }
                        $$.size = size;
                    }
                ;

name:           IDENTIFIER
                    {   strcpy($$, $1);
                    }
                ;

key:            IDENTIFIER
                    {   strcpy($$, $1);
                    }
                ;

fields:         field SYM_COMMA fields
                    {   int i = 0;
                        while (i < size) {
                            strcpy($$[i].name, $3[i].name);
                            strcpy($$[i].value, $3[i].value);
                            i++;
                        }
                        strcpy($$[i].name, $1.name);
                        strcpy($$[i].value, $1.value);
                        size++;
                    }
                | field
                    {   size = 0;
                        strcpy($$[size].name, $1.name);
                        strcpy($$[size].value, $1.value);
                        size++;
                    }
                ;

field:          IDENTIFIER SYM_EQUAL string
                    {   strcpy($$.name, $1);
                        strcpy($$.value, $3);
                    }
                ;

string:         IDENTIFIER string
                    {   sprintf($$, "%s %s", $1, $2);
                    }
                | IDENTIFIER
                    {   strcpy($$, $1);
                    }
                | BRACE_OPEN string_all BRACE_CLOSE
                    {   strcpy($$, $2);
                    }
                | BRACE_OPEN BRACE_CLOSE
                    {   strcpy($$, "");
                    }
                | QUOTES string_all QUOTES
                    {   strcpy($$, $2);
                    }
                | QUOTES QUOTES
                    {   strcpy($$, "");
                    }
                ;

string_all:     IDENTIFIER
                    {   strcpy($$, $1);
                    }
                | SYM_COMMA string_all
                    {   sprintf($$, ", %s", $2);
                    }
                | IDENTIFIER string_all
                    {   sprintf($$, "%s %s", $1, $2);
                    }
                ;

%%


int main (int argc, char *argv[])
{
    yyparse ();
}

int yyerror (char *s)
{
    printf ("Error: %s\n", s);
    return 0;
}
