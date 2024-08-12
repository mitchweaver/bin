all: install

install:
	mkdir -p ${HOME}/.local/bin
	install -m 0755 bin/* ${HOME}/.local/bin/
	install -m 0755 non-shell/* ${HOME}/.local/bin/

test:
	sh check.sh
