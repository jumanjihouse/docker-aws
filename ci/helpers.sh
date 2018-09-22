# shellcheck shell=bash

################################################################################
# This collection of helper functions is sourced by the ci scripts.
################################################################################

# Helper functions.
err() {
  echo "[ERROR] $*" >&2
}

info() {
  echo "[INFO] $*" >&2
}

run() {
  echo >&2
  echo "[RUN] $*" >&2
  # shellcheck disable=SC2048
  $*
}

warn() {
  echo "[WARN] $*" >&2
}

finish() {
  declare -ri RC=$?

  if [ ${RC} -eq 0 ]; then
    echo
    echo "[PASS] $0 OK" >&2
  else
    err "$0 failed with exit code ${RC}"
  fi
}

handle_err() {
  declare -ri RC=$?

  # $BASH_COMMAND contains the command that was being executed at the time of the trap
  # ${BASH_LINENO[0]} contains the line number in the script of that command
  err "exit code ${RC} from \"${BASH_COMMAND}\" on line ${BASH_LINENO[0]}"

  exit ${RC}
}

is_ci() {
  # Are we running in hands-free CI?
  [[ -n "${CIRCLECI:-}" ]]
}

is_git_dirty() {
  # https://gist.github.com/sindresorhus/3898739
  git diff --quiet --ignore-submodules HEAD
}

check_top_dir() {
  declare git_dir
  git_dir="$(git rev-parse --show-toplevel)"
  readonly git_dir

  if ! [[ "$PWD" == "${git_dir}" ]]; then
    err Please run these scripts from the root of the repo
    exit 1
  fi
}

# Traps.
# NOTE: In POSIX, beside signals, only EXIT is valid as an event.
#       You must use bash to use ERR.
trap finish EXIT
trap handle_err ERR
