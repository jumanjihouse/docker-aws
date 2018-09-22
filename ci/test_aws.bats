# vim: set ts=2 sw=2 ai et:

CAPS='--cap-drop all'

@test "awscli shows help with no options" {
  run docker run --rm --read-only ${CAPS} jumanjiman/aws
  [[ ${output} =~ SYNOPSIS ]]
}

@test "awscli is the correct version" {
  run docker run --rm --read-only ${CAPS} jumanjiman/aws --version
  [[ ${output} =~ ${VERSION} ]]
}
