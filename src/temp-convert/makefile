PREFIX = ${HOME}/.local
CFLAGS = -std=c99 -pedantic -O2 -fstack-protector-strong -pipe
CC = cc

$(NAME): 
	$(CC) $(CFLAGS) FtoC.c -o FtoC
	$(CC) $(CFLAGS) CtoF.c -o CtoF

install:
	install -D -m 0755 FtoC $(PREFIX)/bin/FtoC
	install -D -m 0755 CtoF $(PREFIX)/bin/CtoF

uninstall:
	rm $(PREFIX)/bin/FtoC $(PREFIX)/bin/CtoF

clean:
	rm FtoC CtoF 2>/dev/null ||:
