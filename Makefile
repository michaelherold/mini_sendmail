PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
MANPREFIX ?= $(PREFIX)/share/man
DESTDIR   ?= _build

CFLAGS  += -O -ansi -pedantic -U__STRICT_ANSI__ -Wall -Wextra -std=c99
LDFLAGS += -s -static

SRC = mini_sendmail.c
OBJ = $(SRC:.c=.o)

all: mini_sendmail

VPATH = src

include Sourcedeps

$(OBJ): Makefile

clean:
	rm -f $(OBJ) mini_sendmail

mini_sendmail: $(OBJ)

install: all
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -pf mini_sendmail "$(DESTDIR)$(BINPREFIX)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)"/man8
	cp doc/mini_sendmail.8 "$(DESTDIR)$(MANPREFIX)"/man8

.PHONY: all clean install
