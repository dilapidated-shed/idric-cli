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

# Separate Indeed client; the existing Jobicy targets remain available.
IDRIC ?= idris2
ICK ?= ick
ICK_FLAGS ?=
ICU_ROOT ?=
.PHONY: indeed indeed-test install-indeed
indeed:
	"$(GREASE)" checkpoints/indeed/build.grease

indeed-test:
	"$(GREASE)" checkpoints/indeed/check.grease

install-indeed:
	"$(GREASE)" checkpoints/indeed/install.grease "$(DESTDIR)$(PREFIX)"

# NHTSA vPIC typed Idriç client; prerequisites are installed by a separately
# source-pinned Kitchen stage, never silently fetched by make.
NHTSA_PROGRAM ?= $(CURDIR)/build/exec/nhtsa-vin
.PHONY: nhtsa-vin install-nhtsa-vin nhtsa-vin-test
nhtsa-vin:
	test -n "$(ICU_ROOT)" && test -f "$(ICU_ROOT)/native/transport.c"
	"$(IDRIC)" --build nhtsa-vin.ipkg
	test -d build/exec/nhtsa-vin_app
	"$(ICK)" -fno-link-libatomic $(ICK_FLAGS) -std=c11 -O2 -Wall -Wextra -Werror -fPIC -shared \
		"$(ICU_ROOT)/native/transport.c" \
		-o build/exec/nhtsa-vin_app/libicu_transport.so -lssl -lcrypto
	test -x build/exec/nhtsa-vin
	build/exec/nhtsa-vin --version

install-nhtsa-vin:
	test -x build/exec/nhtsa-vin
	test -s build/exec/nhtsa-vin_app/libicu_transport.so
	install -d "$(DESTDIR)$(PREFIX)/bin/nhtsa-vin_app"
	cp -R build/exec/nhtsa-vin_app/. "$(DESTDIR)$(PREFIX)/bin/nhtsa-vin_app/"
	install -m 0755 build/exec/nhtsa-vin "$(DESTDIR)$(PREFIX)/bin/nhtsa-vin"
	"$(DESTDIR)$(PREFIX)/bin/nhtsa-vin" --version

nhtsa-vin-test:
	NHTSA_PROGRAM="$(NHTSA_PROGRAM)" bash test/nhtsa-vin-test.sh
