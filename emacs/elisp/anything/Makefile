
PACKAGE=../../package
OCCUR=$(PACKAGE)/color-moccur-*
ANYTHING=$(PACKAGE)/anything-1*
ANY_CONFIG=$(PACKAGE)/anything-config-*
ANY_MATCH=$(PACKAGE)/anything-match-plugin-*
ANY_SHOW=$(PACKAGE)/anything-show-completion-*
ANYTHING_OPT=-L $(ANYTHING) -L $(ANY_CONFIG) -L $(ANY_MATCH) -L $(ANY_SHOW)
all: bytecompile

bytecompile:
	emacs -q -L .  -L ../misc -L $(OCCUR) $(ANYTHING_OPT) -batch -f batch-byte-compile *.el
#	emacs -f byte-compile *.el

clean:
	rm -f *.elc *~
