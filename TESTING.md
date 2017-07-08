### Test locally

An acceptance test harness runs on
[circleci.com](https://circleci.com/gh/jumanjihouse/docker-awscli)
for each pull request.
The easiest way to test is to open a PR, which tests changes on CircleCI.

As an alternative, you can run the acceptance test harness locally to verify operation:

    ci/test

The test harness uses [BATS](https://github.com/sstephenson/bats).
Output resembles:

		✓ awscli shows help with no options
		✓ awscli is the correct version
		- ci-build-url label is present (skipped: This test only runs on CircleCI)

		3 tests, 0 failures, 1 skipped
