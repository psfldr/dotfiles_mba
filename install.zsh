#!/bin/zsh

# installation
# create: 2020-08-10
# environment:
#   MacBook Air Mid 2012
#   macOS Catalina version 10.15.6
#   pre-installed zsh 5.7.1 (x86_64-apple-darwin19.0)
# execution:
#   zsh install.sh 2>&1 | tee install.log
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
    DATE_STR=$(date "+%Y-%m-%d %H:%M:%S")
    if [[ $1 = 'INFO' ]]; then
        COLOR_SETTING=''
    elif [[ $1 = 'WARNING' ]]; then
        COLOR_SETTING=$(tput setaf 3)
    elif [[ $1 = 'ERROR' ]]; then
        COLOR_SETTING=$(tput setaf 1)
    fi
    echo -e "${COLOR_SETTING}[${DATE_STR}] $2$(tput sgr 0)"
}

echo_with_date 'INFO' "zsh version: ${ZSH_VERSION}^D"

# install Homebrew
echo_with_date 'INFO' 'install Homebrew'
if ! (( $+commands[brew] )); then
    echo_with_date 'INFO' 'Get Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo_with_date 'WARNING' 'skipped Homebrew installation: already installed.'
fi

# install softwares according to Brewfile
echo_with_date 'INFO' 'update Homebrew'
brew update
echo_with_date 'INFO' 'install softwares according to Brewfile'
brew bundle

# install dotfiles with mackup
echo_with_date 'INFO' 'install dotfiles with mackup'
mackup restore

# install Tmux Plugin Manager
echo_with_date 'INFO' 'install Tmux Plugin Manager'
if [ -d ~/.tmux/plugins/tpm ]; then
    echo_with_date 'WARNING' 'skipped Tmux Plugin Manager installation: ~/.tmux/plugins/tpm exists'
else
    echo_with_date 'INFO' 'clone Tmux Plugin Manager repo'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install Vim-Plug
echo_with_date 'INFO' 'install Vim-Plug'
if [ -f ~/.vim/autoload/plug.vim ]; then
    echo_with_date 'WARNING' 'skipped Vim-Plug installation: ~/.vim/autoload/plug.vim exists'
else
    echo_with_date 'INFO' 'curl get plub.vim script'
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo_with_date 'INFO' 'installation completed.'
echo_with_date 'WARNING' 'To install Tmux plugins, start tmux and press `prefix + I`'
echo_with_date 'WARNING' 'To install Vim plugins, start vim and execute `:PlugInstall`'

