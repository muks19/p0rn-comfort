# $Id: Makefile,v 1.3 2004-05-14 18:43:48 mitch Exp $

NAME=p0rn-comfort
VERSION=$(shell grep 'my \$$VERSION' p0rn-proxy | cut -d \" -f 2)
DISTDIR=$(NAME)-$(VERSION)
TARGZ=$(NAME)-$(VERSION).tar.gz

PERLSCRIPTS=p0rn-dbadd p0rn-dbdel p0rn-dblist p0rn-download p0rn-proxy p0rn-dbrestore
SHELLSCRIPTS=p0rn-dbdump p0rn-grab
BINARIES=$(PERLSCRIPTS) $(SHELLSCRIPTS)
OTHERFILES=README

DOCDIR=./docs
POD2MANOPTS=--release=$(VERSION) --center=$(NAME) --section=1

all: generate-manpages dist

generate-manpages:
	rm -rf $(DOCDIR)
	mkdir $(DOCDIR)
	for FILE in $(PERLSCRIPTS);  do pod2man $(POD2MANOPTS) $$FILE     $(DOCDIR)/$$FILE.1; done
	for FILE in $(SHELLSCRIPTS); do pod2man $(POD2MANOPTS) $$FILE.pod $(DOCDIR)/$$FILE.1; done

dist:
	rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	mkdir $(DISTDIR)/P0rn
	mkdir $(DISTDIR)/out
	mkdir $(DISTDIR)/$(DOCDIR)
	cp $(BINARIES) $(OTHERFILES) $(DISTDIR)/
	cp P0rn/DB.pm $(DISTDIR)/P0rn/
	cp $(DOCDIR) $(DISTDIR)/$(DOCDIR)
	tar -c $(DISTDIR) -zvf $(TARGZ)
	rm -rf $(DISTDIR)
