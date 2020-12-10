source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dpkg --version | head -1 | awk '{print $7}')"
  [ "$result" = "${pkg_version}" ]
}
