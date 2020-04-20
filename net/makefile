PREFIX = /usr/local
SCRIPT = interface winterface

all:
	@echo "Use 'make install'"

install:
	install -D -m 0755 ${SCRIPT} ${DESTDIR}${PREFIX}/bin/

test:
	shellcheck -s sh ${SCRIPT}
