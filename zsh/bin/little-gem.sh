#!/usr/bin/env sh

# Script for initialize a Ruby project 
# The project is added in your current directory

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

gen_gemspec() {
  cat >> "$PROJ_LOW/$PROJ_LOW.gemspec" <<- _EOF_
# frozen_string_literal: true

require_relative 'lib/$PROJ_LOW/version'

# https://guides.rubygems.org/specification-reference/
Gem::Specification.new do |s|
  s.name = '$PROJ_LOW'
  s.summary = 'Awesome Ruby Project !'
  s.version = $PROJ_CAP::VERSION
  s.platform = Gem::Platform::RUBY

  s.description = <<-DESCRIPTION
    $PROJ is just an awesome gem !
  DESCRIPTION

  s.email = '$EMAIL'
  s.homepage = 'https://github.com/$USERNAME/$PROJ'
  s.license = 'MIT'
  s.author = '$USERNAME'

  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/$USERNAME/$PROJ/issues',
    'changelog_uri' => 'https://github.com/$USERNAME/$PROJ/blob/main/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/$USERNAME/$PROJ',
    'wiki_uri' => 'https://github.com/$USERNAME/$PROJ/wiki',
    'funding_uri' => 'https://patreon.com/$USERNAME',
  }

  s.files = Dir.glob('{lib,bin}/**/*', File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
  s.files += %w[CHANGELOG.md LICENSE README.md]
  s.files += %w[$PROJ_LOW.gemspec]

  s.bindir = 'bin'
  s.executables << '$PROJ_LOW'
  s.extra_rdoc_files = %w[README.md]

  s.cert_chain = %w[certs/$USERNAME.pem]
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')

  s.required_ruby_version = '>=$RUBY_VERSION_REQUIRED'
  s.requirements << 'TODO change: libmagick, v6.0'
  s.requirements << 'TODO change: A good graphics card'
  s.add_runtime_dependency 'thor', '~> 1.0'
end
_EOF_

    chmod 744 "$PROJ_LOW/$PROJ_LOW.gemspec"
}

gen_lib() {
  cat >> "$PROJ_LOW/lib/$PROJ_LOW.rb" <<- _EOF_
# frozen_string_literal: true

require_relative '$PROJ_LOW/version'
module $PROJ_CAP
end
_EOF_

  chmod 744 "$PROJ_LOW/lib/$PROJ_LOW.rb"
}

gen_changelog() {
  cat >> "$PROJ_LOW"/CHANGELOG.md <<- _EOF_
## 0.0.1, release $(date "+%D")
* Initial push, code freeying !
"
_EOF_
    chmod 744 "$PROJ_LOW/CHANGELOG.md"
}

gen_readme() {
  cat >> "$PROJ_LOW/README.md" <<- _EOF_
# $PROJ_CAP
Awesome ruby gem to build: $PROJ !

## Gem build

    gem build $PROJ.gemspec

## Gem push

    gem login
    gem push $PROJ-0.0.1.gem

## Install $PROJ locally

    gem install $PROJ-0.0.1.gem -P HighSecurity

_EOF_

    chmod 744 "$PROJ_LOW/README.md"
}

gen_version() {
  cat >> "$PROJ_LOW/lib/$PROJ_LOW/version.rb" <<- _EOF_
# frozen_string_literal: true
module $PROJ_CAP
  VERSION = '0.0.1'
end
_EOF_

    chmod 744 "$PROJ_LOW/lib/$PROJ_LOW/version.rb"
}

gen_bin() {
  cat >> "$PROJ_LOW/bin/$PROJ_LOW" <<- _EOF_
#!/usr/bin/env ruby
# frozen_string_literal: true

require '$PROJ_LOW'

puts '$PROJ_CAP v.' + $PROJ_CAP::VERSION
_EOF_

  chmod 755 "$PROJ_LOW/bin/$PROJ_LOW"
}

gen_rakefile() {
  cat >> "$PROJ_LOW/Rakefile" <<- _EOF_
# frozen_string_literal: true

require 'rake/testtask'
require File.dirname(__FILE__) + '/lib/$PROJ_LOW/version'

# run rake
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

# Usage: rake gem:build
namespace :gem do
  desc 'build the gem'
  task :build do
  Dir['$PROJ_LOW*.gem'].each { |f| File.unlink(f) }
    system('gem build $PROJ_LOW.gemspec')
    system("gem install $PROJ_LOW-#{$PROJ_CAP::VERSION}.gem -P HighSecurity")
  end
end

task default: :test
_EOF_
}

gen_test() {
  cat >> "$PROJ_LOW/test/test_$PROJ_LOW.rb" <<- _EOF_
# frozen_string_literal: true

require 'minitest/autorun'
require '$PROJ_LOW'

class Test$PROJ_CAP < Minitest::Test
  def test_version
    assert_equal '0.0.1', $PROJ_CAP::VERSION
  end
end

_EOF_
}

gen_MIT_license() {
  cat >> "$PROJ_LOW/LICENSE" <<- _EOF_
MIT License

Copyright (c) $(date '+%Y') $USERNAME

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"
_EOF_

  chmod 744 "$PROJ_LOW/LICENSE"
}

copy_pubkey() {
    PUBKEY="$HOME/.ssh/gem-public_cert.pem"
    [ -f "$PUBKEY" ] || {
        echo "[-] No public key found."
        return
    }
    cp -v "$PUBKEY" "$PROJ/certs/$USERNAME.pem"
}

git_init() {
    if ! hash git 2>/dev/null ; then
        echo "[-] git was no found"
        return
    fi
    (
        cd "$PROJ" \
            && git init \
            && git add . \
            && git commit -a -S -m "initial commit" \
            && git branch -M main \
            && git remote add origin "https://github.com/$USERNAME/$PROJ.git"
    )
    echo "===> Git initialized, you can push this gem with:"
    echo "cd $PROJ && git push -u origin main"
}

create_project() {
    echo "===> Building your gem project $PROJ"
    mkdir -p "$PROJ/bin"
    mkdir -p "$PROJ/lib"
    mkdir -p "$PROJ/lib/$PROJ_LOW"
    mkdir -p "$PROJ/certs"
    mkdir -p "$PROJ/test"
    gen_changelog
    gen_readme
    gen_gemspec
    gen_lib
    gen_version
    gen_bin
    gen_rakefile
    gen_test
    gen_MIT_license
    copy_pubkey
    git_init
}

make_vars() {
    PROJ_LOW=$(echo "${PROJ}" | tr '[:upper:]' '[:lower:]')
    PROJ_CAP=$(echo "${PROJ}" | sed -E 's/[[:alpha:]]+/\u&/g')
    #echo "===> Lowered $PROJ_LOW"
    #echo "===> Cap $PROJ_CAP"
}

main() {
    echo "Calling $0 in $(pwd)"
    [ -z "$PROJ" ] && usage_die "No project name specified"
    [ -d "$PROJ" ] && die "$PROJ exist alrealy..."
    make_vars
    create_project
    echo "===> You can try your gem with:"
    echo "cd $PROJ"
    echo "ruby -I lib bin/$PROJ_LOW"
    printf "\n+cyaa+\n"
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
