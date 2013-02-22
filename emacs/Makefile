
all: install

clean:
	find . -name "*~" | xargs rm -f
	find load -name "*.elc" | xargs rm -f
	find elisp -name "*.elc" | xargs rm -f

install:
	ln -f -s ~/local/common/emacs/dot.emacs.el ~/.emacs
