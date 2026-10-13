PREFIX ?= /usr/local
DESTDIR ?=
SHELL ?= /bin/sh

.PHONY: test install

test:
	bash test/az-test.sh
	bash test/abe-test.sh

install:
	install -d "$(DESTDIR)$(PREFIX)/bin"
	install -m 0755 bin/az "$(DESTDIR)$(PREFIX)/bin/az"
	install -m 0755 bin/abe "$(DESTDIR)$(PREFIX)/bin/abe"

# Kitchen owns the product build, installation and installed-command tests.
GREASE ?= grease
KITCHEN_ROOT ?=
.PHONY: jobicy install-jobicy jobicy-test
jobicy:
	test -n "$(KITCHEN_ROOT)"
	"$(GREASE)" "$(KITCHEN_ROOT)/tasks/jobicy-cli/1.grease" build "$(CURDIR)"

install-jobicy:
	test -n "$(KITCHEN_ROOT)"
	"$(GREASE)" "$(KITCHEN_ROOT)/tasks/jobicy-cli/1.grease" install "$(CURDIR)" "$(DESTDIR)$(PREFIX)"

jobicy-test:
	test -n "$(KITCHEN_ROOT)"
	"$(GREASE)" "$(KITCHEN_ROOT)/tasks/jobicy-cli/1.grease" test "$(CURDIR)"
