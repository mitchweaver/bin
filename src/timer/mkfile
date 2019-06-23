PREFIX=${HOME}/bin/local
NAME=timer
CC=gcc

${NAME}: 
	${CC} ${NAME}.c -o ${NAME}

install:
	mkdir -p ${PREFIX}/bin
	mv -f ${NAME} ${PREFIX}/bin

uninstall:
	rm -f ${PREFIX}/bin/${NAME}

clean:
	rm -f ${NAME}
