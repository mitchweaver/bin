PREFIX = /usr/local

all:
	@>&2 echo "Use 'make install'"

install:
	for script in * ; do \
		[ -x $$script ] && \
		install -m 0755 $$script ${PREFIX}/bin ; \
	done

uninstall:
	for script in * ; do \
		[ -x ${PREFIX}/bin/$$script ] && \
		rm ${PREFIX}/bin/$$script ; \
	done
