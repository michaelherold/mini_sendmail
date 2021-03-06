VERCMD    ?= git describe 2> /dev/null
VERSION   := $(shell $(VERCMD) || cat VERSION)
BUILDDATE := $(date "+%Y-%m-%d")
BUILD     := "$(VERSION) $(BUILDDATE)"

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
MANPREFIX ?= $(PREFIX)/share/man
DESTDIR   ?= _build

CFLAGS  += -O -ansi -pedantic -U__STRICT_ANSI__ -Wall -Wextra -std=c99 -DMINI_SENDMAIL_BUILD=\"${BUILD}\"
LDFLAGS += -s -static

SRC = mini_sendmail.c
OBJ = $(SRC:.c=.o)

all: mini_sendmail

VPATH = src

include Sourcedeps

$(OBJ): Makefile

clean:
	rm -f $(OBJ) mini_sendmail
	rm -rf ./_build

mini_sendmail: $(OBJ)

install: all
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -pf mini_sendmail "$(DESTDIR)$(BINPREFIX)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)"/man8
	cp doc/mini_sendmail.8 "$(DESTDIR)$(MANPREFIX)"/man8

package:
	dpkg-buildpackage -us -uc

test: all
	bats test

.PHONY: all clean install package test
