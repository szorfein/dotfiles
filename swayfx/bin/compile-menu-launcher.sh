#!/usr/bin/env sh

set -o errexit

# This script just compile fsel with otter-launcher
# cURL, Rust with Cargo are required

REPOS="fsel otter-launcher"
WORKDIR="$HOME/tmp/rust"

FSEL_ZIP="https://github.com/Mjoyufull/fsel/archive/refs/heads/main.zip"
OTTE_ZIP="https://github.com/kuokuo123/otter-launcher/archive/refs/heads/main.zip"

reset_work() {
    PKG_WORK="$WORKDIR/$1"
    [ -d "$PKG_WORK" ] && rm -rf "$PKG_WORK"
    mkdir -p "$PKG_WORK"
}

compile_it() {
    unzip "$1".zip
    cd "$1"-main
    cargo build --release
    cp target/release/"$1" "$HOME/bin/"
}

build_fsel() {
    cd "$WORKDIR/fsel"
    curl -o fsel.zip -sSL "$FSEL_ZIP"
    compile_it fsel
}

build_otte() {
    cd "$WORKDIR/otter-launcher"
    curl -o otter-launcher.zip -sSL "$OTTE_ZIP"
    compile_it otter-launcher
}

rust_build() {
    PKGNAME="$1"
    reset_work "$PKGNAME"
}

for repo in $REPOS; do
    rust_build "$repo"
done

build_fsel
build_otte
