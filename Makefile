# vim: set ts=8 sw=8 ai noet:

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
	bats test/test_*.bats
