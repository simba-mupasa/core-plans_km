pkg_origin=core
pkg_name=consul
pkg_version=1.0.7
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_description="Consul is a tool for service discovery, monitoring and configuration."
pkg_upstream_url=https://www.consul.io/
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=6c2c8f6f5f91dcff845f1b2ce8a29bd230c11397c448ce85aae6dacd68aa4c14
pkg_filename=${pkg_name}-${pkg_version}_linux_amd64.zip
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port-dns]=ports.dns
  [port-http]=ports.http
  [port-serf_lan]=ports.serf_lan
  [port-serf_wan]=ports.serf_wan
  [port-server]=ports.server
)
pkg_exposes=(port-dns port-http port-serf_lan port-serf_wan port-server)

pkg_svc_user=root
pkg_svc_group=root

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D consul "${pkg_prefix}/bin/consul"
}
