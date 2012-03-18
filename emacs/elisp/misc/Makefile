
all: bytecompile

bytecompile:
	emacs -Q -L . -L ../anything -L ../auto-complete-1.3 -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
