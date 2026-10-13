PREFIX ?= /usr/local
DESTDIR ?=
SHELL ?= /bin/sh
IDRIC ?= idris2
GREASE ?= grease
ICK ?= ick
ICK_FLAGS ?=
ICU_ROOT ?=

.PHONY: test install indeed indeed-test install-indeed

indeed:
	$(GREASE) checkpoints/indeed/build.grease

indeed-test:
	$(GREASE) checkpoints/indeed/check.grease

install-indeed:
	$(GREASE) checkpoints/indeed/install.grease "$(DESTDIR)$(PREFIX)"

test:
	bash test/az-test.sh
	bash test/abe-test.sh

install:
	install -d "$(DESTDIR)$(PREFIX)/bin"
	install -m 0755 bin/az "$(DESTDIR)$(PREFIX)/bin/az"
	install -m 0755 bin/abe "$(DESTDIR)$(PREFIX)/bin/abe"
