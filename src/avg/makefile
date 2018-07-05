PREFIX=${HOME}/bin/local
# CC=tcc
CC=gcc

all: avg

avg: 
	${CC} avg.c -o avg

install:
	@echo installing to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@mv -f avg ${PREFIX}/bin

uninstall:
	@echo uninstalling from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/avg

clean:
	rm -f avg
