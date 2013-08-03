PACKAGE=../../package
ANYTHING=$(PACKAGE)/anything-2*
AUTOCOMPLETE=$(PACKAGE)/auto-complete-2*
CMOCCUR=$(PACKAGE)/color-moccur-2*
POPUP=$(PACKAGE)/popup-2*

OPT=-L $(ANYTHING) -L $(CMOCCUR) -L $(AUTOCOMPLETE) -L $(POPUP)
all: bytecompile

bytecompile:
	emacs -Q -L . $(OPT) -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
