PROGRAM=slre

all: test $(PROGRAM)

SOURCES = $(shell find . -maxdepth 1 -name "*.c")

OBJS = $(SOURCES:.c=.o)

CFLAGS= -O2 -g -Wall
LDFLAGS= -Wl,-z,defs -Wl,--as-needed -Wl,--no-undefined
INCS=-I.
DEFS=
LIBS=

PKG_CONFIG=
PKG_CONFIG_CFLAGS=`pkg-config --cflags $(PKG_CONFIG) 2>/dev/null`
PKG_CONFIG_LIBS=`pkg-config --libs $(PKG_CONFIG) 2>/dev/null`

INCS+=$(PKG_CONFIG_CFLAGS)
LIBS+=$(PKG_CONFIG_LIBS)

$(PROGRAM): $(OBJS)
	g++ $(LDFLAGS) $+ -o $@ $(LIBS)

slre-test: slre.c
	gcc -o $@  $(INCS) -DSLRE_UNIT_TEST $(DEFS) $+ $(CFLAGS) $(LDFLAGS) $(LIBS)

test: slre-test
	./slre-test

%.o: %.cpp
	g++ -o $@ $(INCS) $(DEFS) -c $+ $(CFLAGS)

%.o: %.c
	gcc -o $@  $(INCS) $(DEFS) -c $+ $(CFLAGS)

clean:
	rm -fv $(OBJS)
	rm -fv $(PROGRAM)
	rm -fv slre-test
	rm -fv *.o *.a *~
