all: sum

sum: 
	gcc sum.c -o sum

install:
	@echo installing to ${HOME}/bin/bin
	@mkdir -p ${HOME}/bin/bin
	@cp -f sum ${HOME}/bin/bin

uninstall:
	@echo uninstalling from ${HOME}/bin/bin
	@rm -f ${HOME}/bin/bin/sum

clean:
	rm -f sum
