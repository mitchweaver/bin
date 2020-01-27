PREFIX = ${HOME}/.local
NAME = timer
CFLAGS = -O2 -static -std=c99
CC = gcc

$(NAME): 
	$(CC) $(CFLAGS) $(NAME).c -o $(NAME)

install:
	install -Dm0755 $(NAME) $(PREFIX)/bin/$(NAME)

uninstall:
	rm -f $(PREFIX)/bin/$(NAME)

clean:
	rm -f $(NAME)
