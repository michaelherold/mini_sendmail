BINDIR  = /usr/local/sbin
MANDIR  = /usr/local/man
CC      = cc
CFLAGS  = -O -ansi -pedantic -U__STRICT_ANSI__ -Wall -Wpointer-arith \
          -Wshadow -Wcast-qual -Wcast-align -Wstrict-prototypes \
          -Wmissing-prototypes -Wmissing-declarations -Wredundant-decls \
          -Wno-long-long
LDFLAGS = -s -static

CC := $(DIET) $(CC)

all: mini_sendmail

clean:
	rm -f mini_sendmail *.o core core.* *.core

mini_sendmail: mini_sendmail.o
	$(CC) $(LDFLAGS) mini_sendmail.o -o mini_sendmail

mini_sendmail.o: mini_sendmail.c version.h
	$(CC) $(CFLAGS) -c mini_sendmail.c

install: all
	rm -f $(BINDIR)/mini_sendmail
	cp mini_sendmail $(BINDIR)
	rm -f $(MANDIR)/man8/mini_sendmail.8
	cp mini_sendmail.8 $(MANDIR)/man8
