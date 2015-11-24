# vim: set ts=8 sw=8 ai noet:

# If you change this, you must also update circle.yml and Dockerfile.
VERSION = 1.9.9

ifdef CIRCLECI
	CAPS =
else
	CAPS = --cap-drop all
endif

.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f jumanjiman/aws || :

.PHONY: runtime
runtime:
	docker build --rm -t jumanjiman/aws .
	docker images | grep aws

.PHONY: test
test:
	docker run --rm --read-only ${CAPS} jumanjiman/aws 2>&1 | grep SYNOPSIS
	docker run --rm --read-only ${CAPS} jumanjiman/aws --version 2>&1 | grep ${VERSION}
