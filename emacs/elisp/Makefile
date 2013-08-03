
all:
	$(MAKE) bytecompile

bytecompile: yatex1.77/lp.el
	$(MAKE) bytecompile -C elscreen
	$(MAKE) bytecompile -C misc

yatex1.77/lp.el:
	$(MAKE) bytecompile -C yatex1.77

clean:
	rm yatex1.77/lp.el
	find . -name "*.elc" | xargs rm -f
	find . -name "*~" | xargs rm -f
