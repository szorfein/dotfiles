#!/usr/bin/env sh

set -o errexit

WORK_DIR="$(mktemp -d)"
export GNUPGHOME="$WORK_DIR"

echo "hi $WORK_DIR"
echo "hi $GNUPGHOME"

cat > foo << EOF
%echo Generating a basic OpenPGP key
Key-Type: RSA
Key-Length: 4096
Key-Usage: cert
Expire-Date: 5y
Subkey-Type: RSA
Subkey-Length: 4096
Subkey-Usage: sign
Subkey-Expire-Date: 6m
Name-Real: Rod
Name-Email: rod@test.org 
%no-protection
%commit
%echo done
EOF

gpg --batch --generate-key foo

sleep 10
get_fpr=$(gpg -K | awk '{print $1}' | grep '^[[:digit:]]')
echo "get fingerprint -> $get_fpr"

echo "Generating encrypt key for $get_fpr"
gpg --batch --quick-add-key "$get_fpr" rsa4096 encrypt 6m &
wait
sleep 10

echo "Generating auth key for $get_fpr"
gpg --batch --quick-add-key "$get_fpr" rsa4096 auth 6m &
wait

gpg --list-secret-keys
