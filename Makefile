target: all

all: hash.o lex.yy.o y.tab.o
	gcc -o etapa2  hash.o lex.yy.o y.tab.o

hash.o: hash.c
	gcc -c hash.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: scanner.l
	lex scanner.l

y.tab.o: y.tab.c
	gcc -c y.tab.c

y.tab.c: parser.y
	yacc parser.y -d

clean: 
	rm *.o
	rm etapa2
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
