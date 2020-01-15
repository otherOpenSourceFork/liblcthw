#CFLAGS=-g -Wall -Wextra -Isrc
CFLAGS=-Wno-incompatible-pointer-types -Wno-implicit-function-declaration -g -Isrc
PREFIX?=/usr/local
OBJECTS=$(patsubst %.c,%.o,$(wildcard src/lcthw/*.c))
TESTS=$(patsubst %.c,%,$(wildcard tests/*_tests.c))
TARGET=src/lcthw/liblcthw.a

all: $(TARGET) tests

$(TARGET): $(OBJECTS)
	ar rcs $@ $(OBJECTS)

.PHONY: tests
tests: LDLIBS += $(TARGET) -lbsd -lm
tests: $(TESTS)

clean:
	rm -rf $(TARGET)
	rm -rf $(OBJECTS)
	rm -rf $(TESTS)

install: all
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -d $(DESTDIR)$(PREFIX)/include/lcthw
	install -d $(DESTDIR)$(PREFIX)/include/lcthw/tests
	install -m 0644 $(TARGET) $(DESTDIR)$(PREFIX)/lib/
	install -m 0644 tests/minunit.h $(DESTDIR)$(PREFIX)/include/lcthw/tests
	install -m 0644 src/lcthw/*.h $(DESTDIR)$(PREFIX)/include/lcthw
