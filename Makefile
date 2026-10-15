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

# The Amazon.jobs product is compiled from Idriç. The build host must provide
# the maintained Idriç compiler and its contrib JSON package.
.PHONY: amazon-jobs amazon-jobs-test
amazon-jobs:
	"$(IDRIC)" -p contrib checkpoints/amazon-jobs/AmazonJobs.idric -o amazon-jobs

amazon-jobs-test: amazon-jobs
	./build/exec/amazon-jobs --self-test
