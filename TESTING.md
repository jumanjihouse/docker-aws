### Test locally

An acceptance test harness runs on
[circleci.com](https://circleci.com/gh/jumanjihouse/docker-awscli)
for each pull request.
The easiest way to test is to open a PR, which tests changes on CircleCI.

As an alternative, you can run the acceptance test harness locally to verify operation:

    ci/test

The test harness uses [BATS](https://github.com/sstephenson/bats).
Output resembles:

    [forbid-binary] Forbid binaries..............................................................Passed
    [git-check] Check for conflict markers and core.whitespace errors............................Passed
    [git-dirty] Check if the git tree is dirty...................................................Passed
    [shellcheck] Test shell scripts with shellcheck..............................................Passed
    [yamllint] yamllint..........................................................................Passed
    [check-added-large-files] Check for added large files........................................Passed
    [check-case-conflict] Check for case conflicts...............................................Passed
    [check-executables-have-shebangs] Check that executables have shebangs.......................Passed
    [check-json] Check JSON..................................................(no files to check)Skipped
    [detect-private-key] Detect Private Key......................................................Passed
    [forbid-crlf] CRLF end-lines checker.........................................................Passed
    [forbid-tabs] No-tabs checker................................................................Passed

    Invoke BATS tests.
     ok awscli shows help with no options
     ok awscli is the correct version
     - ci-build-url label is present (skipped: This test only runs on CircleCI)
     ok version label is correct

    4 tests, 0 failures, 1 skipped

    Check every file for things like trailing whitespace.
    INFO: OK
