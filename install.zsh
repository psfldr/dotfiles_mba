#!/bin/zsh

# installation
# create: 2020-08-10
# environment:
#   MacBook Air Mid 2012
#   macOS Catalina version 10.15.6
#   pre-installed zsh 5.7.1 (x86_64-apple-darwin19.0)
# execution:
#   zsh install.sh 2>&1 | tee install.log
# procedure:
#   1. install Homebrew
#   2. install other software with homebrew
#   3. install dotfiles
#   4. configure 'defaults'
# note:
#   Homebrew installation requies xcode command line tool.
#   Install it by
#     sudo xcodebuild -license
#     xcode-select --install
#   beforehand or by accepting request
#   from Homebrew in "System Preference -> Software Update"

set -euo pipefail

echo_with_date() {
    # Add date and time before echo output.
    DATE_STR="[`date \"+%Y-%m-%d %H:%M:%S\"`]"
    echo ""$DATE_STR $1""
}

echo_with_date "zsh version: $ZSH_VERSION"

# install Homebrew
if ! (( $+commands[brew] )); then
    echo_with_date 'Get Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo_with_date 'skipped Homebrew installation: already installed.'
fi

# install softwares according to Brewfile
echo_with_date 'install softwares according to Brewfile'
brew bundle

echo_with_date 'installation completed.'
