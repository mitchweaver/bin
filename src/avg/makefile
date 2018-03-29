PREFIX=${HOME}/bin/local

all: avg

avg: 
	gcc avg.c -o avg

install:
	@echo installing to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@mv -f avg ${PREFIX}/bin

uninstall:
	@echo uninstalling from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/avg

clean:
	rm -f avg
