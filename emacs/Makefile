
all: install

clean:
	find . -name "*~" | xargs rm -f
	find load -name "*.elc" | xargs rm -f
	find elisp -name "*.elc" | xargs rm -f

install:
	ln -f -s ~/local/common/emacs/init.el ~/.emacs.d/init.el
	mkdir -p ~/.emacs.d/tmp
