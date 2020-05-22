PREFIX = ${HOME}/.local

all:
	@>&2 echo "Use 'make install'."

install:
	######personal 
	for d in application daemon media rice utility wrapper ; do \
		install -D -m 0755 $$d/* ${DESTDIR}${PREFIX}/bin/ ; \
	done

test:
	shellcheck -s sh application/*
	shellcheck -s sh daemon/*
	shellcheck -s sh media/*
	shellcheck -s sh misc/*
	shellcheck -s sh personal/*
	shellcheck -s sh rice/*
	shellcheck -s sh utility/*
	shellcheck -s sh wrapper/*
