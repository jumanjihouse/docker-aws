# vim: set ts=8 sw=8 ai noet:

.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f jumanjiman/aws || :

.PHONY: runtime
runtime:
	docker build \
		--build-arg CI_BUILD_URL=${CIRCLE_BUILD_URL} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		--rm -t jumanjiman/aws .
	docker images | grep aws

.PHONY: test
test:
	bats test/test_*.bats
