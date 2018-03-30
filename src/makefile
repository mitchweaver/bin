all: src

src:
	for i in $$(ls) ; do \
		[ -d $$i ] && \
		cd $$i && \
		make && \
		cd .. ; \
	done

install:
	for i in $$(ls) ; do \
		[ -d $$i ] && \
		cd $$i && \
		make install && \
		cd .. ; \
	done

uninstall:
	for i in $$(ls) ; do \
		[ -d $$i ] && \
		cd $$i && \
		make uninstall && \
		cd .. ; \
	done

clean:
	for i in $$(ls) ; do \
		[ -d $$i ] && \
		cd $$i && \
		make clean && \
		cd .. ; \
	done
