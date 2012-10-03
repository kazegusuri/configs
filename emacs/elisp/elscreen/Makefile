
all: bytecompile

bytecompile:
	emacs -Q -L ../misc/ -batch -f batch-byte-compile elscreen.el
	emacs -Q -L ../misc/ -l elscreen.elc -batch -f batch-byte-compile elscreen*.el

clean:
	rm -f *.elc *~

