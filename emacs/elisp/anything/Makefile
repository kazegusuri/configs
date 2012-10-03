
PACKAGE=../../package
OCCUR=$(PACKAGE)/color-moccur-*
all: bytecompile

bytecompile:
	emacs -q -L . -L ../misc -L $(OCCUR) -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
