all:
	lt-comp rl apertium-eu-hu.eu-hu.dix hu-eu.autobil.bin
	cg-comp apertium-eu-hu.hu-eu.rlx hu-eu.rlx.bin

	if [ ! -d .deps ]; then mkdir .deps ; fi

	hfst-lexc apertium-eu-hu.hu.lexc > .deps/hu-eu.lexc.hfst
	hfst-twolc -R -i apertium-eu-hu.hu.twol -o .deps/hu-eu.twol.hfst
	hfst-compose-intersect -1 .deps/hu-eu.lexc.hfst -2 .deps/hu-eu.twol.hfst -o .deps/hu-eu.gen.hfst
	hfst-invert .deps/hu-eu.gen.hfst | hfst-substitute -F apertium-eu-hu.hu.relabel > .deps/hu-eu.morf.hfst
	hfst-fst2fst -O .deps/hu-eu.morf.hfst -o hu-eu.automorf.hfst

	hfst-lexc apertium-eu-hu.eu.lexc > .deps/eu-hu.lexc.hfst
	hfst-twolc -R -i apertium-eu-hu.eu.twol -o .deps/eu-hu.twol.hfst
	hfst-compose-intersect -1 .deps/eu-hu.lexc.hfst -2 .deps/eu-hu.twol.hfst -o .deps/eu-hu.gen.hfst
	hfst-invert .deps/eu-hu.gen.hfst | hfst-substitute -F apertium-eu-hu.eu.relabel > .deps/eu-hu.morf.hfst
	hfst-invert .deps/eu-hu.morf.hfst | hfst-fst2fst -O -o hu-eu.autogen.hfst

	hfst-fst2fst -O .deps/eu-hu.morf.hfst -o eu-hu.automorf.hfst
clean:
	rm -rf .deps hu-eu.autobil.bin hu-eu.rlx.bin
