#!/usr/bin/env sh

# Script for initialize a Ruby project 
# The project is added in your current directory
#
# Usage: little-gem.sh [-p NAME]
# Examples:
# little-gem.sh -p awesome

set -o errexit -o nounset

PROJ=""
RUBY_VERSION_REQUIRED="2.6"
USERNAME="$(git config --get user.name)"
EMAIL="$(git config --get user.email)"

die() { echo "[-] $1"; exit 1; }

usage() {
    printf "\nUsage:\n"
    printf "\t-p [NAME]\t A name for your ruby project.\n"
    printf "\t-h\t\tDisplay this help.\n"
}

usage_die() { usage; die "$1"; }
cat_file() {
    cat <<EOF | tee "$PROJ"/"$2" >/dev/null
$1
EOF
}

gen_gemspec() {
    content="
require File.dirname(__FILE__) + \"/lib/$PROJ_LOW/version\"
Gem::Specification.new do |s|
  s.name = \"$PROJ_LOW\"
  s.version = $PROJ_CAP::VERSION
  s.summary = \"Awesome Ruby Project !\"
  s.author = [\"$USERNAME\"]
  s.email = [\"$EMAIL\"]
  s.homepage = \"project url | github page\"
  s.metadata = \{
    \"changelog_uri\" => \"https://github.com/$USERNAME/$PROJ/blob/master/CHANGELOG.md\",
    \"bug_tracker_uri\" => \"https://github.com/$USERNAME/$PROJ/issues\",
    \"wiki_uri\" => \"https://github.com/$USERNAME/$PROJ/docs\",
  \}
  s.license = \"MIT\"
  s.required_ruby_version = \">=$RUBY_VERSION_REQUIRED\"
  s.files = \`git ls-files\`.split(\" \")
  s.files.reject! { |fn| fn.include? \"certs\" }
  s.executables = [ \"$PROJ_LOW\" ]
  s.cert_chain = [\"certs/$USERNAME.pem\"]
  s.signing_key = File.expand_path(\"~/.ssh/gem-private_key.pem\") if \$@ =~ /gem\z/
end
"
    cat_file "$content" "$PROJ_LOW.gemspec"
}

gen_lib() {
    content="
require_relative '$PROJ_LOW/version'
module $PROJ_CAP
end
"
    cat_file "$content" "lib/$PROJ_LOW.rb"
}

gen_changelog() {
    content="
## 0.0.1, release $(date "+%D")
* Initial push, code freeying !
"
    cat_file "$content" "CHANGELOG.md"
}

gen_readme() {
    content="
# $PROJ_CAP
"
    cat_file "$content" "README.md"
}

gen_version() {
    content="
module $PROJ_CAP
  VERSION = '0.0.1'.freeze
end
"
    cat_file "$content" "lib/$PROJ_LOW/version.rb"
}

gen_bin() {
    content="
#!/usr/bin/env ruby
require '$PROJ_LOW'
print "$PROJ_CAP::VERSION"
"
    cat_file "$content" "bin/$PROJ_LOW"
    chmod 700 "$PROJ/bin/$PROJ_LOW"
}

create_project() {
    echo "===> Create project $PROJ"
    mkdir -p "$PROJ"/{bin,lib,certs}
    mkdir -p "$PROJ"/lib/"$PROJ_LOW"
    gen_changelog
    gen_readme
    gen_gemspec
    gen_lib
    gen_version
    gen_bin
}

make_vars() {
    PROJ_LOW=${PROJ,,}
    PROJ_CAP=${PROJ^}
    #echo "===> Lowered $PROJ_LOW"
    #echo "===> Cap $PROJ_CAP"
}

main() {
    echo "Calling $0 in $(pwd)"
    [ -z "$PROJ" ] && usage_die "No project name specified"
    [ -d "$PROJ" ] && die "$PROJ exist alrealy..."
    make_vars
    create_project
    echo "You can try your gem with:"
    echo "cd $PROJ"
    echo "ruby -I lib bin/$PROJ_LOW"
    echo "cyaa"
    exit 0
}

[ "$#" -gt 0 ] || usage_die "No args specified."
while getopts ":pvh" args; do
    opt="$1"
    shift
    case "$opt" in
        -p) PROJ="$1"; shift;;
        -v | -h) usage; exit 0;;
        *) usage_die "Bad arg $opt"
    esac
done

main "$@"
