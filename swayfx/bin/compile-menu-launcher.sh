#!/usr/bin/env sh

set -o errexit

# This script just compile fsel with otter-launcher
# cURL, Rust with Cargo are required

REPOS="fsel otter-launcher"
WORKDIR="$HOME/tmp/rust"

# Void linux finally compile the 3.0.0, rustc v1.93.0
FSEL_V="3.0.0"
FSEL_ZIP="https://github.com/Mjoyufull/fsel/archive/refs/tags/$FSEL_V.zip"
OTTE_V="main"
OTTE_ZIP="https://github.com/kuokuo123/otter-launcher/archive/refs/heads/$OTTE_V.zip"

reset_work() {
    PKG_WORK="$WORKDIR/$1"
    [ -d "$PKG_WORK" ] && rm -rf "$PKG_WORK"
    mkdir -p "$PKG_WORK"
}

compile_it() {
    unzip "$1".zip
    cd "$1"-"$2"
    cargo build --release
    cp target/release/"$1" "$HOME/bin/"
    echo "Success with $1"
}

build_fsel() {
    cd "$WORKDIR/fsel"
    curl -o fsel.zip -sSL "$FSEL_ZIP"
    compile_it fsel "$FSEL_V"
}

build_otte() {
    cd "$WORKDIR/otter-launcher"
    curl -o otter-launcher.zip -sSL "$OTTE_ZIP"
    compile_it otter-launcher "$OTTE_V"
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
