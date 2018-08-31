PREFIX=${HOME}/bin/local
CC=gcc

all: timer

timer: 
	${CC} timer.c -o timer

install:
	@echo installing to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@mv -f timer ${PREFIX}/bin

uninstall:
	@echo uninstalling from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/timer

clean:
	rm -f timer
