all: install

install:
	mkdir -p ${HOME}/.local/bin
	install -m 0755 bin/* ${HOME}/.local/bin/
	install -m 0755 non-shell/* ${HOME}/.local/bin/
	if [ `uname` = "FreeBSD" ] ; then \
		install -m 0755 freebsd-bin/* ${HOME}/.local/bin/ ; \
	fi
	if [ `uname` = "Linux" ] ; then \
		install -m 0755 linux-bin/* ${HOME}/.local/bin/ ; \
	fi

test:
	sh check.sh
