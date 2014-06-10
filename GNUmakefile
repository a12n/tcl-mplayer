VSN = $(shell head -n 1 mplayer.tcl | cut -d ' ' -f 4)

GEN_SCRIPTS = pkgIndex.tcl
SCRIPTS = $(GEN_SCRIPTS) mplayer.tcl

DESTDIR ?= /usr/local/share/tcltk
PREFIX = $(DESTDIR)/mplayer$(VSN)

.PHONY: all clean install
.SUFFIXES: .tcl .tcl.in

all: $(SCRIPTS)

clean:
	rm -f $(GEN_SCRIPTS)

install: all
	install -d $(PREFIX)
	for SCRIPT in $(SCRIPTS); do \
		install -m 664 $$SCRIPT $(PREFIX)/$$SCRIPT; \
	done

pkgIndex.tcl: mplayer.tcl
	echo "pkg_mkIndex . $^" | tclsh

.tcl.in.tcl:
	sed -e 's,<<VSN>>,$(VSN),g' $< > $@
