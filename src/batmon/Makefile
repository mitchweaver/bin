NAME = batmon
PREFIX = /usr/local
CFLAGS = -std=c99 -pedantic -O2 -fstack-protector-strong -pipe
CC = cc

$(NAME): 
	$(CC) $(CFLAGS) $(NAME).c -o $(NAME)

install:
	install -D -m 0755 $(NAME) $(PREFIX)/bin/$(NAME)

uninstall:
	rm $(PREFIX)/bin/$(NAME)

clean:
	rm $(NAME) 2>/dev/null ||:
