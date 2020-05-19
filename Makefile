PREFIX = ${HOME}/.local

all:
	@>&2 echo "Use 'make install'."

install:
	@>&2 echo 'Not implemented.'

test:
	shellcheck -s sh application/*
	shellcheck -s sh daemon/*
	shellcheck -s sh media/*
	shellcheck -s sh personal/*
	shellcheck -s sh utility/*
	shellcheck -s sh wrapper/*
