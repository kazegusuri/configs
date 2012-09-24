
all: bytecompile

bytecompile:
	emacs -Q -L . -L ../anything -L ../auto-complete -batch -f batch-byte-compile *.el

clean:
	rm -f *.elc *~
