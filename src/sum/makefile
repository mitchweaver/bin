PREFIX=${HOME}/bin/local
# CC=tcc
CC=gcc

all: sum

sum: 
	${CC} sum.c -o sum

install:
	@echo installing to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@mv -f sum ${PREFIX}/bin

uninstall:
	@echo uninstalling from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/sum

clean:
	rm -f sum
