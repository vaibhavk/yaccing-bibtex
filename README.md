## Learning Yacc/Bison
_Stop yacking, start yaccing!_

This is an example parser for BibTeX, made for the Compilers Lab
course at JIIT,Noida.
An accompanying blog post will be written soon

### What is what
    
    parse.y         : define the grammar
    lex.l           : token definitions
    types.h         : datatypes for the parser
    util.c/util.h   : utility functions
    y.tab.c/y.tab.h : yacc generated grammar parser
    lex.yy.c        : lex generated token parser


### How to
```bash
$ make
$ ./bibtex_parser < testcases.txt
$ # or
$ make test
```

### Author
Vaibhav Kaushik
