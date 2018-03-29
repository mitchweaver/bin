PREFIX=${HOME}/bin/local

all: sum

sum: 
	gcc sum.c -o sum

install:
	@echo installing to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@mv -f sum ${PREFIX}/bin

uninstall:
	@echo uninstalling from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/sum

clean:
	rm -f sum
