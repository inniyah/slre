PROGRAM=slre

all: $(PROGRAM)

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

%.o: %.cpp
	g++ -o $@ $(INCS) $(DEFS) -c $+ $(CFLAGS) $(EXTRA_CFLAGS)

%.o: %.c
	gcc -o $@  $(INCS) $(DEFS) -c $+ $(CFLAGS) $(EXTRA_CFLAGS)

clean:
	rm -f $(OBJS)
	rm -f $(PROGRAM)
	rm -f *.o *.a *~
