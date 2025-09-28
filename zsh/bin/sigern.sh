#!/usr/bin/env sh

# Script to sign kernel modules
# Usage: sigern.sh

set -o errexit -o nounset

KERNEL="/usr/src/linux"
SIG_KEY="$KERNEL"/certs/signing_key.pem
SIG_KEY_X509="${SIG_KEY%.*}".x509
SIG_FILE="$KERNEL"/scripts/sign-file
SIG_HASH=$(grep -Po '(?<=CONFIG_MODULE_SIG_HASH=").*(?=")' "$KERNEL/.config")

die() { echo "[-] $1"; exit 1; }

echo "check key..."
[ -f "$SIG_KEY" ] || die "No key $SIG_KEY found"
[ -f "$SIG_KEY_X509" ] || die "No key $SIG_KEY_X509 found"
[ -f "$SIG_FILE" ] || die "No script $SIG_FILE found"

check_root() {
  if [ $(id -u) -ne 0 ] ; then
    die "Launch this script as root please"
  fi
}

echo "Found $SIG_KEY"
virtualbox() {
  if ! hash VirtualBox 2>/dev/null ; then return ; fi
  echo "==> Virtualbox modules"
  for mod in $(dirname $(modinfo -n vboxdrv))/*.ko; do
    echo "signing $mod"
    "$SIG_FILE" "$SIG_HASH" "$SIG_KEY" "$SIG_KEY_X509" "$mod"
  done
  echo "Done"
}

main() {
  check_root
  virtualbox
}

main "$@"
