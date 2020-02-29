PREFIX = ${HOME}/.local
NAME = timer
CFLAGS = -O2 -static -std=c99 -pedantic
CC = gcc

$(NAME): 
	$(CC) $(CFLAGS) $(NAME).c -o $(NAME)

install:
	install -D -m 0755 $(NAME) $(PREFIX)/bin/$(NAME)

uninstall:
	rm $(PREFIX)/bin/$(NAME)

clean:
	rm $(NAME)
