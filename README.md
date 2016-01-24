AWS CLI
=======

This git repo provides [AWS CLI](http://aws.amazon.com/cli/)
from [PIP](https://pypi.python.org/pypi/awscli) in a Docker container.

Project: [https://github.com/jumanjihouse/docker-aws]
(https://github.com/jumanjihouse/docker-aws)<br/>
Docker image: [https://registry.hub.docker.com/u/jumanjiman/aws/]
(https://registry.hub.docker.com/u/jumanjiman/aws/)<br/>
Upstream release notes: [http://aws.amazon.com/releasenotes/CLI]
(http://aws.amazon.com/releasenotes/CLI)

[![Image Size](https://img.shields.io/imagelayers/image-size/jumanjiman/aws/latest.svg)](https://imagelayers.io/?images=jumanjiman/aws:latest 'View image size and layers')&nbsp;
[![Image Layers](https://img.shields.io/imagelayers/layers/jumanjiman/aws/latest.svg)](https://imagelayers.io/?images=jumanjiman/aws:latest 'View image size and layers')&nbsp;
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/aws.svg)](https://registry.hub.docker.com/u/jumanjiman/aws)&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/docker-aws.png?circle-token=5303a3a083c3d19463bbd1b08937b24b3417d70e)](https://circleci.com/gh/jumanjihouse/docker-aws/tree/master 'View CI builds')

[![Throughput Graph](https://graphs.waffle.io/jumanjihouse/docker-aws/throughput.svg)](https://waffle.io/jumanjihouse/docker-aws/metrics)


How-to
------

### Build and test

We use circleci to build, test, and publish the image to Docker hub.
We use [BATS](https://github.com/sstephenson/bats) to run the test harness.
BATS output resembles:

    ✓ awscli shows help with no options
    ✓ awscli is the correct version

    2 tests, 0 failures


### Pull an already-built image

    docker pull jumanjiman/aws


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

    # Put your keys in the redacted values.
    function aws {
      docker run --rm -it \
      -e AWS_ACCESS_KEY_ID=redacted \
      -e AWS_SECRET_ACCESS_KEY=redacted \
      -e AWS_DEFAULT_REGION=us-west-2 \
      jumanjiman/aws $@
    }

Then `source ~/.bashrc` and simply run `aws <your args>`.
