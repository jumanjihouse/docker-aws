@test "ci-build-url label is present" {
  if [ -z $CIRCLECI ]; then
    skip "This test only runs on CircleCI"
  fi
  run docker inspect \
      -f '{{ index .Config.Labels "io.github.jumanjiman.ci-build-url" }}' \
      jumanjiman/aws
  [[ ${output} =~ circleci.com ]]
}

@test "version label is correct" {
  run docker inspect \
      -f '{{ index .Config.Labels "io.github.jumanjiman.version" }}' \
      jumanjiman/aws
  [[ ${output} =~ ${VERSION} ]]
}
