PACKAGE=../../package
ANYTHING=$(PACKAGE)/anything-1*
AUTOCOMPLETE=$(PACKAGE)/auto-complete-*
ANY_MATCH=$(PACKAGE)/anything-match-plugin-*
CMOCCUR=$(PACKAGE)/color-moccur-*
POPUP=$(PACKAGE)/popup-*

#ANY_SHOW=$(PACKAGE)/anything-show-completion-*
OPT=-L $(ANYTHING) -L $(ANY_MATCH) -L $(CMOCCUR) -L $(AUTOCOMPLETE) -L $(POPUP)
all: bytecompile

bytecompile:
	emacs -Q -L . $(OPT) -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
