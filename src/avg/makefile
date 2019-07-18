PREFIX=${HOME}/.local
NAME=avg
CFLAGS='-Wall -pedantic -O2 -static'
#CC='gcc'
CC='tcc'

$(NAME): 
	$(CC) $(CFLAGS) $(NAME).c -o $(NAME)

install:
	install -Dm0755 $(NAME) $(PREFIX)/bin/$(NAME)

uninstall:
	rm -f $(PREFIX)/bin/$(NAME)

clean:
	rm -f $(NAME)
