
all: bytecompile

bytecompile:
	emacs -q -L . -L ../misc -L ../occur -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
