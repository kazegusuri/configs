
all: bytecompile

bytecompile:
	emacs -Q -L ../apel-10.7/ -batch -f batch-byte-compile elscreen.el
	emacs -Q -L ../apel-10.7/ -l elscreen.elc -batch -f batch-byte-compile elscreen*.el

clean:
	rm -f *.elc *~

