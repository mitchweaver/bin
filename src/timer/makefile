PREFIX = ${HOME}/.local
NAME = timer
SCRIPT_NAME = clocktimer
CFLAGS = -O2 -static -std=c99 -pedantic
CC = gcc

$(NAME): 
	$(CC) $(CFLAGS) $(NAME).c -o $(NAME)

install:
	install -D -m 0755 $(NAME)        $(PREFIX)/bin/$(NAME)
	install -D -m 0755 $(SCRIPT_NAME) $(PREFIX)/bin/$(SCRIPT_NAME)

uninstall:
	rm $(PREFIX)/bin/$(NAME) $(PREFIX)/bin/$(SCRIPT_NAME)

clean:
	rm $(NAME) 2>/dev/null ||:
