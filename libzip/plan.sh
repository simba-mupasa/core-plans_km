pkg_name=libzip
pkg_origin=core
pkg_version=1.5.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A C library for reading, creating, and modifying zip archives"
pkg_upstream_url="https://libzip.org/"
pkg_license=('BSD-3-Clause')
pkg_source="${pkg_upstream_url}/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=47eaa45faa448c72bd6906e5a096846c469a185f293cafd8456abb165841b3f2
pkg_deps=(
  core/bzip2-musl
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/bzip2-musl
  core/cmake
  core/gcc
  core/gcc-libs
  core/make
  core/openssl
  core/zlib
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_setup_environment() {
  set_buildtime_env BUILD_DIR "build"
}

do_prepare() {
  mkdir -p "${BUILD_DIR}"
}

do_build() {
  pushd "${BUILD_DIR}" > /dev/null

  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DCMAKE_INSTALL_LIBDIR="${pkg_prefix}/lib/" \
    -DCMAKE_PREFIX_PATH="$(pkg_path_for zlib)" \
    -DZLIB_INCLUDE_DIR="$(pkg_path_for zlib)/include" \
    -DOPENSSL_INCLUDE_DIR="$(pkg_path_for openssl)/include" \
    -DOPENSSL_ROOT_DIR="$(pkg_path_for openssl)" \
    ..

  make -j "$(nproc)"
  popd > /dev/null
}

do_install() {
  pushd "${BUILD_DIR}" > /dev/null
  do_default_install
  popd > /dev/null
}
