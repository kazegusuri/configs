
all: bytecompile

bytecompile:
	emacs -q -L . -L ../misc -L ./extensions -L ../occur -batch -f batch-byte-compile *.el extensions/*el

clean:
	rm -f *.elc *~ extensions/*.elc
