DIR = ~/local/common/screen

all: install

clean:
	rm -f *~

install:
	@if [ ! -e ~/.screenrc  ]; then ln -s ${CURDIR}/screenrc ~/.screenrc; fi;

