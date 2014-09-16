TARGET = learn_c_101
SRC = $(wildcard src/*.[c])
OBJ = $(SRC:.c=.o)
PREFIX = /tmp/learn_c_101
BINDIR = $(PREFIX)/bin
DEBUG = true

CC = gcc
CFLAGS   = -fPIC -O3 -w -pipe $(ARCH_FLAG)
ifdef DEBUG
	CFLAGS += -ggdb -Ddebug
endif
INCFLAGS = -I.
LDFLAGS =

RM = rm -vf
RM_RF = rm -vrf
MKDIR = mkdir -p
RMDIR = rmdir --ignore-fail-on-non-empty -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) --strip -D --backup=numbered -m 0755
INSTALL_DATA = $(INSTALL) -D --backup=numbered -m 644

.PHONY: all install clean watch
.SUFFIXES: .c .o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJ)

%.o : %.c
	$(CC) $(CFLAGS) $(INCFLAGS) -c $< -o $@

watch:
	while true; do
		change=$(inotifywait -r -e close_write,moved_to,create .)
		change=${change#./ * }
		make
		./learn_c_101 FooBar
	done

clean:
	$(RM) $(TARGET) $(OBJ)

install:
	$(INSTALL_PROG) $(TARGET) $(BINDIR)/$(TARGET)

uninstall:
	$(RM) $(BINDIR)/$(TARGET)

uninstallall: uninstall
	$(RM) $(BINDIR)/$(TARGET).*
	$(RMDIR) $(PREFIX)

