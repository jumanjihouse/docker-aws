# AWS CLI

This git repo provides [AWS CLI](http://aws.amazon.com/cli/)
from [PIP](https://pypi.python.org/pypi/awscli) in a Docker container.

[![Github jumanjihouse/dockeraws](https://img.shields.io/badge/Github-jumanjihouse/dockeraws-orange.svg)](https://github.com/jumanjihouse/docker-aws)&nbsp;
[![Docker_Hub jumanjiman/aws](https://img.shields.io/badge/Docker_Hub-jumanjiman/aws-orange.svg)](https://registry.hub.docker.com/u/jumanjiman/aws/)&nbsp;
[![Upstream Changelog](https://img.shields.io/badge/Upstream-Changelog-orange.svg)](https://github.com/aws/aws-cli/blob/develop/CHANGELOG.rst)&nbsp;

[![Download size](https://images.microbadger.com/badges/image/jumanjiman/aws.svg)](http://microbadger.com/images/jumanjiman/aws "View on microbadger.com")
[![Version](https://images.microbadger.com/badges/version/jumanjiman/aws.svg)](http://microbadger.com/images/jumanjiman/aws "View on microbadger.com")
[![Source code](https://images.microbadger.com/badges/commit/jumanjiman/aws.svg)](http://microbadger.com/images/jumanjiman/aws "View on microbadger.com")
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/aws.svg)](https://registry.hub.docker.com/u/jumanjiman/aws/)&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/docker-aws.png?circle-token=5303a3a083c3d19463bbd1b08937b24b3417d70e)](https://circleci.com/gh/jumanjihouse/docker-aws/tree/master 'View CI builds')

[![Image last updated](https://img.shields.io/badge/dynamic/json.svg?url=https://api.microbadger.com/v1/images/jumanjiman/aws&label=Image%20last%20updated&query=$.LastUpdated&colorB=007ec6)](http://microbadger.com/images/jumanjiman/aws "View on microbadger.com")&nbsp;

An updated version of this image is generally available within a few hours
after a new version of awscli becomes available. See below for more details.

**Table of Contents**

- [Overview](#overview)
  - [References](#references)
  - [Build integrity](#build-integrity)
- [How-to](#how-to)
  - [Report issues](#report-issues)
  - [Pull an already-built image](#pull-an-already-built-image)
  - [View labels](#view-labels)
  - [Configure](#configure)
  - [Run](#run)
  - [Build locally](#build-locally)
  - [Test locally](#test-locally)
- [Licenses](#licenses)


Overview
--------

The AWS Command Line Interface (CLI) is a unified tool to manage
your AWS services. With just one tool to download and configure,
you can control multiple AWS services from the command line and
automate them through scripts.

This repo provides a way to build AWS CLI into
a docker image and run it as a container.


### References

* [AWS CLI docs](https://aws.amazon.com/cli/)
* [Python Package Index](https://pypi.python.org/pypi/awscli)
* [AWS Developer Blog](https://aws.amazon.com/blogs/developer/super-charge-your-aws-command-line-experience-with-aws-shell/)
* [Changelog](https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst)


### Build integrity

The repo is set up to install the software in a minimal image.

![workflow](assets/docker_hub_workflow.png)

An unattended test harness runs the [build script](ci/build)
and runs acceptance tests.
If all tests pass on master branch in the unattended test harness,
it pushes the built images to the Docker hub.

We trigger a parameterized build on circleci multiple times per day.
When there is a new version of awscli on pip, we build and publish a new image.
See [`ci/autobuild`](ci/autobuild) for details.


How-to
------

### Report issues

* For issues with the Docker image build of this git repo:
  https://github.com/jumanjihouse/docker-aws/issues

* For security issues with the upstream awscli:
  https://aws.amazon.com/security/contact/

To contribute enhancements to this repo, please see
[`CONTRIBUTING.md`](CONTRIBUTING.md) in this repo.


### Pull an already-built image

These images are built as part of the test harness on CircleCI.
If all tests pass on master branch, then the image is pushed
into the docker hub.

    docker pull jumanjiman/aws

The "latest" tag always points to the latest version.
In general, you should prefer to use a pessimistic (i.e., specific) tag.

We provide multiple tags:

* optimistic:  `jumanjiman/aws:latest`
* pessimistic: `jumanjiman/aws:<version>-<builddate>-git-<hash>`

Example:

    jumanjiman/aws:1.11.117-20170707T1040-git-ab34c6e
                   ^^^^^^^^ ^^^^^^^^^^^^^     ^^^^^^^
                       |         |              |
                       |         |              +--> hash from this git repo
                       |         |
                       |         +-----------------> build date and time
                       |
                       +---------------------------> version of awscli


These tags allow to correlate any image to the application version,
the build date and time,
and the git commit from this repo that was used to build the image.

We push the tags automatically from the test harness, and
we occasionally delete old tags from the Docker hub by hand.
See https://hub.docker.com/r/jumanjiman/aws/tags/ for released tags.


### View labels

Each built image has labels that generally follow http://label-schema.org/

We add a label, `ci-build-url`, that is not currently part of the schema.
This extra label provides a permanent link to the CI build for the image.

View the ci-build-url label on a built image:

    docker inspect \
      -f '{{ index .Config.Labels "io.github.jumanjiman.ci-build-url" }}' \
      jumanjiman/aws

Query all the labels inside a built image:

    docker inspect jumanjiman/aws | jq -M '.[].Config.Labels'


### Configure

See the [official AWS CLI docs](http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
for how to persist configuration in a file. Otherwise, see below to use environment variables.


### Run

Interactively:

    docker run --rm -it \
    -e AWS_ACCESS_KEY_ID=<snip> \
    -e AWS_SECRET_ACCESS_KEY=<snip> \
    -e AWS_DEFAULT_REGION=us-west-2  \
    --read-only \
    --cap-drop all \
    jumanjiman/aws ec2 describe-instances

As a simplification, add this to your `~/.bashrc`:

    # Use a remote docker host.
    export DOCKER_HOST='tcp://192.168.254.162:2375'

    # Put your secrets in the redacted values.
    export AWS_ACCESS_KEY_ID=redacted
    export AWS_SECRET_ACCESS_KEY=redacted
    export AWS_DEFAULT_REGION=redacted

    function aws {
      docker run --rm -it \
      -e AWS_ACCESS_KEY_ID \
      -e AWS_SECRET_ACCESS_KEY \
      -e AWS_DEFAULT_REGION \
      --read-only \
      --cap-drop all \
      jumanjiman/aws $@
    }

Then `source ~/.bashrc` and simply run `aws <your args>`.

The above example uses `--read-only` and `--cap-drop all` as recommended by the
CIS Docker Security Benchmarks:

* [Docker 1.6](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.6_Benchmark_v1.0.0.pdf)
* [Docker 1.11](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.11.0_Benchmark_v1.0.0.pdf)
* [Docker 1.12](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.12.0_Benchmark_v1.0.0.pdf)
* [Docker 1.13](https://benchmarks.cisecurity.org/tools2/docker/CIS_Docker_1.13.0_Benchmark_v1.0.0.pdf)


### Build locally

Build an image locally on a host with Docker:

    # Latest stable version ("optimistic").
    ci/build

    # A specific version ("pessimistic").
    VERSION='1.16.19' ci/build

    # The unstable development version ("v2").
    # https://aws.amazon.com/blogs/developer/aws-cli-v2-development/
    VERSION='2.0.0dev0' ci/build

Run a container interactively from the built image:

    docker run --rm -it jumanjiman/aws


### Test locally

See [TESTING.md](TESTING.md) in this git repo.


Licenses
--------

All files in this repo are subject to [LICENSE.md](LICENSE.md) (also in this repo).
