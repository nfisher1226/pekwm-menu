LIBS= `pkg-config --libs glib-2.0 gtk+-2.0 libmenu-cache`
CFLAGS+= -g -Wall `pkg-config --cflags glib-2.0 gtk+-2.0 libmenu-cache`
CC=gcc
#-DG_DISABLE_DEPRECATED

# Comment this line if you don't want icons to appear in menu
CFLAGS+=-DWITH_ICONS

prefix= /usr/local
DESTDIR ?= $(prefix)
BINDIR= ${DESTDIR}/bin

SRC= $(shell ls *.c 2> /dev/null)
OBJ= $(SRC:.c=.o)

all: $(OBJ) pekwm-menu

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

pekwm-menu: $(OBJ)
	$(CC) $(OBJ) -o pekwm-menu $(LDFLAGS) $(LIBS)

.PHONY: clean install doc changelog check

clean:
	@rm -f *.o pekwm-menu
	@rm -rf doc

install:
	@strip -s pekwm-menu
	@install -Dm 755 pekwm-menu $(BINDIR)/pekwm-menu

changelog:
	@hg log --style changelog > ChangeLog
