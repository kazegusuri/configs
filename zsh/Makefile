CURDIR = ~/local/common/zsh

all: install

clean:
	rm -f *~

install:
	mkdir -p ~/.zsh
	mkdir -p ~/.ssh
	touch ~/.ssh/authorized_keys
	ln -f -s ${CURDIR}/zshenv ~/.zshenv
	ln -s ${CURDIR}/zshrc ~/.zshrc
	ln -s ${CURDIR}/zshlogin ~/.zlogin
	ln -s ${CURDIR}/zshlogout ~/.zlogout
