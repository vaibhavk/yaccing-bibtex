PROGRAM 		= bibtex_parser

CC 				= gcc
CC_FLAGS 		= -Wall -Wno-unused-function -Wno-format-overflow -Wpedantic -g
CC_LFLAGS		= -lfl
CC_LEX			= lex
CC_YACC 		= yacc
YFLAGS 			= -d

SRCS 			= y.tab.c lex.yy.c util.c
OBJS 			= y.tab.o lex.yy.o util.o
INCLUDE_DIR		= .

all: 			${PROGRAM}

.c.o: 			${SRCS}
				${CC} ${CC_FLAGS} -c $*.c -o $@ -O ${CC_LFLAGS}

y.tab.c: 		parse.y
				${CC_YACC} ${YFLAGS} parse.y

lex.yy.c: 		lex.l
				${CC_LEX} lex.l

${PROGRAM}:		${OBJS}
				${CC} ${C_FLAGS} -I${INCLUDE_DIR} -o $@ ${OBJS}


.PHONY: 		test clean

test: 			all
				./${PROGRAM} < testcase.txt

clean:
				rm -f ${OBJS} *.o ${PROGRAM} y.* lex.yy.*
