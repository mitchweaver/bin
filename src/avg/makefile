all: avg

avg: 
	gcc avg.c -o avg

install:
	@echo installing to ${HOME}/bin/bin
	@mkdir -p ${HOME}/bin/bin
	@cp -f avg ${HOME}/bin/bin

uninstall:
	@echo uninstalling from ${HOME}/bin/bin
	@rm -f ${HOME}/bin/bin/avg

clean:
	rm -f avg
