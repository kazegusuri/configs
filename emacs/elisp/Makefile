
all:
	$(MAKE) bytecompile

bytecompile:
	$(MAKE) bytecompile -C yatex1.77
	$(MAKE) bytecompile -C elscreen
	$(MAKE) bytecompile -C misc

clean:
	find . -name "*.elc" | xargs rm -f
	find . -name "*~" | xargs rm -f
