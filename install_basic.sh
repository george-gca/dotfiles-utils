#!/bin/bash
# Created by: George Araújo (george.gcac@gmail.com)
# Currently for Ubuntu 23.04 (Lunar Lobster)

# region Install commands to use

ADD_APT_REPO="sudo add-apt-repository -y"
ADD_PUBLIC_KEY="sudo tee /usr/share/keyrings"
APT_INSTALL="sudo apt install -y"
CARGO_INSTALL="cargo install"
DEFAULT_DEB_NAME="installer.deb"
DOWNLOAD_FILE="aria2c -c -x8 --summary-interval 0 -d . -o $DEFAULT_DEB_NAME"
DPKG_INSTALL="sudo dpkg -i"
DEB_INSTALL="sudo apt install -y"
GET_PUBLIC_KEY="wget -qO-"
GIT_CLONE="git clone --depth 1"
GSET="gsettings set"
PIP_INSTALL="python3 -m pip install --upgrade"
PIPX_INSTALL="pipx install"
SNAP_INSTALL="sudo snap install"
SOFTWARE_DIR="$HOME/Software"
USR_BIN="$HOME/bin"

mkdir -p $SOFTWARE_DIR

# endregion


# region Auxiliary functions

. install_functions.sh

# endregion


# region Create templates for common file types in right click context menu in nautilus

touch ~/Templates/Empty\ Document
echo -e '#!/bin/bash\n' > ~/Templates/Empty\ Bash\ Script.sh
echo -e '#!/usr/bin/python3\n# -*- coding: utf-8 -*-\n' > ~/Templates/Empty\ Python\ Script.py
touch ~/Templates/Empty\ Python\ File.py

# endregion


# region Copy bin/ folder to home and make the scripts executable

cp -r bin $HOME
chmod +x $HOME/bin/*

# endregion


# region Adding repos

# brave browser
$GET_PUBLIC_KEY https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo tee /usr/share/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |\
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# eza - A modern, maintained replacement for ls
$GET_PUBLIC_KEY https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo tee /usr/share/keyrings/gierens.asc
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/gierens.asc] http://deb.gierens.de stable main" |\
  sudo tee /etc/apt/sources.list.d/gierens.list

# Graphic drivers
# $ADD_APT_REPO ppa:graphics-drivers/ppa

# Google Chrome
$GET_PUBLIC_KEY https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' |\
  sudo tee /etc/apt/sources.list.d/google-chrome.list

# Signal Messenger
$GET_PUBLIC_KEY https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# Ubuntu Cleaner
# $ADD_APT_REPO ppa:gerardpuig/ppa

# Vivaldi Web Browser
# $GET_PUBLIC_KEY http://repo.vivaldi.com/stable/linux_signing_key.pub | $ADD_PUBLIC_KEY
# $ADD_APT_REPO "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"

# endregion


# region Installs via apt

sudo apt update -y
$APT_INSTALL aria2  # download manager
$APT_INSTALL autossh  # automatically retry ssh connection
$APT_INSTALL bat  # cat with syntax highlight
$APT_INSTALL brave-browser
$APT_INSTALL build-essential   # essential tools to code
$APT_INSTALL caffeine  # avoids locking screen when active
# $APT_INSTALL cargo  # cargo is the Rust package manager, needed for the installation of other utilities
$APT_INSTALL chrome-gnome-shell  # support gnome-shell extensions installation via Chrome
$APT_INSTALL curl  # transfer data
$APT_INSTALL deluge  # torrent client
$APT_INSTALL eza  # a modern replacement for ‘ls’
# recommended font for usage with exa icon support:
# https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
$APT_INSTALL fd-find  # A simple, fast and user-friendly alternative to 'find'
# $APT_INSTALL flameshot  # screenshots
$APT_INSTALL fzf  # A command-line fuzzy finder
$APT_INSTALL gdu  # Disk usage analyzer (ncdu) with console interface written in Go
# $APT_INSTALL gedit-plugins
$APT_INSTALL gnome-shell-extensions
$APT_INSTALL gnome-tweaks
$APT_INSTALL google-chrome-stable
$APT_INSTALL gstreamer1.0-plugins-bad
$APT_INSTALL gstreamer1.0-plugins-base
$APT_INSTALL gstreamer1.0-plugins-good
# $APT_INSTALL gstreamer1.0-plugins-ugly
$APT_INSTALL gufw # firewall gui
# $APT_INSTALL lm-sensors  # show GPU core temperature
$APT_INSTALL meld  # diff tool
$APT_INSTALL micro  # a modern and intuitive terminal-based text editor
$APT_INSTALL net-tools  # ifconfig
$APT_INSTALL nnn  # the missing terminal file manager for X
$APT_INSTALL pipx  # install and run python applications in isolated environments
$APT_INSTALL python3-gpg  # Dropbox verification of files
$APT_INSTALL python3-dev
$APT_INSTALL python3-pip
$APT_INSTALL python3-tk
$APT_INSTALL python3-venv
$APT_INSTALL rar
$APT_INSTALL ripgrep
# in case of error with ripgrep, do
# sudo dpkg --force-overwrite -i /var/cache/apt/archives/ripgrep*.deb
$APT_INSTALL ssh
$APT_INSTALL tealdeer  # a very fast implementation of tldr in Rust
$APT_INSTALL texlive-full  # latex
$APT_INSTALL tilix  # advanced GTK3 tiling terminal emulator
$APT_INSTALL tlp tlp-rdw  # improve power usage on laptops
$APT_INSTALL ubuntu-restricted-extras
#$APT_INSTALL wine
$APT_INSTALL zoxide  # A fast cd command that learns your habits

# Language support
$APT_INSTALL `check-language-support -l en`
$APT_INSTALL `check-language-support -l pt`

# Signal Messenger
$APT_INSTALL signal-desktop

# Ubuntu Cleaner
# $APT_INSTALL ubuntu-cleaner

# Vivaldi Web Browser
# $APT_INSTALL vivaldi-stable

# endregion


# region Install via dpkg

# bottom - yet another cross-platform graphical process/system monitor
# site=$(get_latest_github_release "ClementTsang/bottom" "bottom_" "_amd64.deb")
# $DOWNLOAD_FILE $site; $DPKG_INSTALL $DEFAULT_DEB_NAME; rm $DEFAULT_DEB_NAME

# Delta - a viewer for git and diff output
site=$(get_latest_github_release "dandavison/delta" "git-delta_" "_amd64.deb")
$DOWNLOAD_FILE $site; $DPKG_INSTALL $DEFAULT_DEB_NAME; rm $DEFAULT_DEB_NAME

# Diskus - a minimal, fast alternative to 'du -sh'
site=$(get_latest_github_release "sharkdp/diskus" "diskus_" "_amd64.deb")
$DOWNLOAD_FILE $site; $DPKG_INSTALL $DEFAULT_DEB_NAME; rm $DEFAULT_DEB_NAME

# Google Chrome
# $DOWNLOAD_FILE https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# $DEB_INSTALL ./$DEFAULT_DEB_NAME
# rm $DEFAULT_DEB_NAME

# Mendeley Reference Manager
# Install Dependencies
# Download it from https://www.mendeley.com/download-reference-manager/linux
$ADD_APT_REPO universe
$APT_INSTALL libfuse2

# endregion


# region Install downloading binary file

# rclone - command-line program to manage files on cloud storage
# curl https://rclone.org/install.sh | sudo bash

# tealdeer - a very fast implementation of tldr in Rust
# site=$(get_latest_github_release_no_v "dbrgn/tealdeer" "tealdeer-linux-x86_64-musl")
# aria2c -c --summary-interval 0 -d $USR_BIN $site
# mv $USR_BIN/tealdeer-linux-x86_64-musl $USR_BIN/tldr
# chmod +x $USR_BIN/tldr
# $USR_BIN/tldr --update

# tealdeer autocompletion for bash
# site=$(get_latest_github_release_no_v "dbrgn/tealdeer" "completions_bash")
# aria2c -c --summary-interval 0 -d . $site
# sudo mv completions_bash /usr/share/bash-completion/completions/tldr

# up - Ultimate Plumber is a tool for writing Linux pipes with instant live preview
# site=$(get_latest_github_release_no_v "akavel/up" "up")
# aria2c -c --summary-interval 0 -d $USR_BIN $site
# chmod +x $USR_BIN/up

# waveterm - An open-source, cross-platform terminal for seamless workflows
# site=$(get_latest_github_release "wavetermdev/waveterm" "waveterm-linux-x64-v" ".zip")
# aria2c -c --summary-interval 0 -d $SOFTWARE_DIR -o waveterm.zip $site
# cd $SOFTWARE_DIR
# unzip waveterm.zip
# rm waveterm.zip
# cd -

# endregion


# region Install via installation script

# Dua - view disk space usage and delete unwanted data, fast
curl -LSfs https://raw.githubusercontent.com/byron/dua-cli/master/ci/install.sh | \
    sh -s -- --git byron/dua-cli --target x86_64-unknown-linux-musl --crate dua

# Node Version Manager
site=$(get_latest_github_raw_no_v "nvm-sh/nvm" "install.sh")
curl -o- $site | bash

# Node (latest version)
. $HOME/.bashrc
nvm install $(nvm ls-remote | grep -i latest | tail -n 1 | sed -ne 's/[^v0-9]*\(\([0-9]*\.\)\{0,4\}[0-9][^.]\).*/\1/p' | xargs)

# Poetry Python Dependency Manager
curl -sSL https://install.python-poetry.org | python3 -

# endregion


# region Installs via snaps

$SNAP_INSTALL code --classic  # vscode
$SNAP_INSTALL htop
$SNAP_INSTALL indicator-sound-switcher
$SNAP_INSTALL lnav  # log file navigator
$SNAP_INSTALL notepad-plus-plus  # text editor with macro support
$SNAP_INSTALL pinta  # simple GTK Paint Program
$SNAP_INSTALL procs  # a modern replacement for ps written in Rust
$SNAP_INSTALL slack
$SNAP_INSTALL spotify
$SNAP_INSTALL telegram-desktop
$SNAP_INSTALL vlc
sudo snap refresh

# endregion


# region Install via pip

$PIP_INSTALL pip
$PIPX_INSTALL asreview
# $PIP_INSTALL colorama  # colorful print
$PIP_INSTALL ipython
# $PIP_INSTALL ipdb
# $PIP_INSTALL jupyter
# $PIP_INSTALL jupyterlab
$PIPX_INSTALL mu-repo
# $PIP_INSTALL pipenv
# $PIP_INSTALL prettytable  # print easy to read tables
$PIPX_INSTALL telegram-send
$PIPX_INSTALL thefuck  # corrects your previous console command
$PIP_INSTALL tqdm

# endregion


# region Install via cargo

# $CARGO_INSTALL --locked navi  # an interactive cheatsheet tool for the command-line
# navi repo add denisidoro/cheats

# endregion


# region Upgrade packages and remove unecessary ones

sudo apt -y upgrade
sudo apt -y autoremove

# endregion


# region Configure flameshot as the default action for PrtScn key

# https://askubuntu.com/questions/1036473/ubuntu-18-how-to-change-screenshot-application-to-flameshot
# Release the PrtScr binding
# $GSET org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
# Set new custom binding
# $GSET org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
# Set name
# $GSET org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
# Set command
# $GSET org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'
# Set binding
# $GSET org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'

# Fix bug when using cedilla in skype and slack
# sudo sh -c 'echo GTK_IM_MODULE=cedilla >> /etc/environment'

# endregion


# region Configure git

bash config_git.sh

# endregion


# region Configure themes

bash install_themes.sh

# endregion


# region Install Ruby (needed for jekyll sites)

$APT_INSTALL libssl-dev libyaml-dev
$GIT_CLONE https://github.com/rbenv/rbenv.git $HOME/.rbenv
. ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
$GIT_CLONE https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install $(rbenv install -l | grep -v - | tail -1)

# endregion
