#!/bin/bash
# Created by: George Araújo (george.gcac@gmail.com)
# Currently for Ubuntu 22.04 LTS (Jammy Jellyfish)

## Install commands to use
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
PIP_INSTALL="python3 -m pip install --user --upgrade"
SNAP_INSTALL="sudo snap install"
USR_BIN="$HOME/bin"


## Auxiliary functions
get_latest_github_release() {
  # usage: get_latest_release "user/repo" "prefix" "suffix"
  version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" |  # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
  version_no_v=$(echo $version | sed -e "s/v//g")
  echo "https://github.com/$1/releases/download/$version/"$2"$version_no_v"$3
}

get_latest_github_release_no_v() {
  # usage: get_latest_release "user/repo" "prefix" "suffix"
  version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" |  # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
  echo "https://github.com/$1/releases/download/$version/"$2
}


## Create templates for common file types in right click context menu in nautilus
touch ~/Templates/Empty\ Document
echo -e '#!/bin/bash\n' > ~/Templates/Empty\ Bash\ Script.sh
echo -e '#!/usr/bin/python3\n# -*- coding: utf-8 -*-\n' > ~/Templates/Empty\ Python\ Script.py
touch ~/Templates/Empty\ Python\ File.py


## Copy bin/ folder to home and make the scripts executable
cp -r bin $HOME
chmod +x $HOME/bin/*


## Adding repos
# Graphic drivers
$ADD_APT_REPO ppa:graphics-drivers/ppa

# Google Chrome
$GET_PUBLIC_KEY https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' |\
  sudo tee /etc/apt/sources.list.d/google-chrome.list

# Signal Messenger
$GET_PUBLIC_KEY https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# Ubuntu Cleaner
$ADD_APT_REPO ppa:gerardpuig/ppa

# Vivaldi Web Browser
# $GET_PUBLIC_KEY http://repo.vivaldi.com/stable/linux_signing_key.pub | $ADD_PUBLIC_KEY
# $ADD_APT_REPO "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"


## Installs via apt
sudo apt update -y
$APT_INSTALL aria2  # download manager
$APT_INSTALL autossh  # automatically retry ssh connection
$APT_INSTALL bat  # cat with syntax highlight
$APT_INSTALL build-essential   # essential tools to code
$APT_INSTALL caffeine  # avoids locking screen when active
# $APT_INSTALL cargo  # cargo is the Rust package manager, needed for the installation of other utilities
$APT_INSTALL chrome-gnome-shell  # support gnome-shell extensions installation via Chrome
$APT_INSTALL curl  # transfer data
$APT_INSTALL deluge  # torrent client
$APT_INSTALL exa  # a modern replacement for ‘ls’
# recommended font for usage with exa icon support:
# https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
$APT_INSTALL fd-find  # A simple, fast and user-friendly alternative to 'find'
# $APT_INSTALL flameshot  # screenshots
$APT_INSTALL fzf  # A command-line fuzzy finder
$APT_INSTALL gdu  # Disk usage analyzer (ncdu) with console interface written in Go
$APT_INSTALL gedit-plugins
$APT_INSTALL gnome-shell-extensions
$APT_INSTALL gnome-tweaks
$APT_INSTALL google-chrome-stable
$APT_INSTALL gstreamer1.0-plugins-bad
$APT_INSTALL gstreamer1.0-plugins-base
$APT_INSTALL gstreamer1.0-plugins-good
# $APT_INSTALL gstreamer1.0-plugins-ugly
# $APT_INSTALL lm-sensors  # show GPU core temperature
$APT_INSTALL meld  # diff tool
$APT_INSTALL micro  # a modern and intuitive terminal-based text editor
$APT_INSTALL net-tools  # ifconfig
$APT_INSTALL nnn  # the missing terminal file manager for X
# $APT_INSTALL python3-gpg  # Dropbox verification of files
$APT_INSTALL python3-dev
$APT_INSTALL python3-pip
$APT_INSTALL python3-tk
$APT_INSTALL python3-venv
$APT_INSTALL rar
$APT_INSTALL ripgrep
# in case of error with ripgrep, do
# sudo dpkg --force-overwrite -i /var/cache/apt/archives/ripgrep*.deb
$APT_INSTALL ssh
$APT_INSTALL texlive-full  # latex
$APT_INSTALL tilix  # advanced GTK3 tiling terminal emulator
$APT_INSTALL tlp tlp-rdw  # improve power usage on laptops
$APT_INSTALL ubuntu-restricted-extras
#$APT_INSTALL wine
$APT_INSTALL zoxide  # A fast cd command that learns your habits

# Firewall
# $APT_INSTALL gufw

# Language support
$APT_INSTALL `check-language-support -l en`
$APT_INSTALL `check-language-support -l pt`

# Signal Messenger
$APT_INSTALL signal-desktop

# Ubuntu Cleaner
$APT_INSTALL ubuntu-cleaner

# Vivaldi Web Browser
# $APT_INSTALL vivaldi-stable


## Install via dpkg
# bottom - yet another cross-platform graphical process/system monitor
site=$(get_latest_github_release "ClementTsang/bottom" "bottom_" "_amd64.deb")
$DOWNLOAD_FILE $site; $DPKG_INSTALL $DEFAULT_DEB_NAME; rm $DEFAULT_DEB_NAME

# Dua - view disk space usage and delete unwanted data, fast
curl -LSfs https://raw.githubusercontent.com/byron/dua-cli/master/ci/install.sh | \
    sh -s -- --git byron/dua-cli --target x86_64-unknown-linux-musl --crate dua

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

# Poetry Python Dependency Manager
curl -sSL https://install.python-poetry.org | python3 -

# tealdeer - a very fast implementation of tldr in Rust
site=$(get_latest_github_release_no_v "dbrgn/tealdeer" "tealdeer-linux-x86_64-musl")
aria2c -c --summary-interval 0 -d $USR_BIN $site
mv $USR_BIN/tealdeer-linux-x86_64-musl $USR_BIN/tldr
chmod +x $USR_BIN/tldr
$USR_BIN/tldr --update

# tealdeer autocompletion for bash
site=$(get_latest_github_release_no_v "dbrgn/tealdeer" "completions_bash")
aria2c -c --summary-interval 0 -d . $site
sudo mv completions_bash /usr/share/bash-completion/completions/tldr

## Install downloading binary file
# up - Ultimate Plumber is a tool for writing Linux pipes with instant live preview
site=$(get_latest_github_release_no_v "akavel/up" "up")
aria2c -c --summary-interval 0 -d $USR_BIN $site
chmod +x $USR_BIN/up


## Installs via snaps
$SNAP_INSTALL code --classic  # vscode
$SNAP_INSTALL htop
$SNAP_INSTALL indicator-sound-switcher
$SNAP_INSTALL lnav  # log file navigator
$SNAP_INSTALL notepad-plus-plus  # text editor with macro support
$SNAP_INSTALL procs  # a modern replacement for ps written in Rust
$SNAP_INSTALL slack
$SNAP_INSTALL spotify
$SNAP_INSTALL telegram-desktop
$SNAP_INSTALL vlc
sudo snap refresh


## Install via pip
# $PIP_INSTALL colorama  # colorful print
$PIP_INSTALL ipython
# $PIP_INSTALL ipdb
# $PIP_INSTALL jupyter
# $PIP_INSTALL jupyterlab
$PIP_INSTALL mu-repo
$PIP_INSTALL pip
# $PIP_INSTALL pipenv
# $PIP_INSTALL prettytable  # print easy to read tables
$PIP_INSTALL telegram-send
$PIP_INSTALL thefuck  # corrects your previous console command
$PIP_INSTALL tqdm


## Install via cargo
# $CARGO_INSTALL --locked navi  # an interactive cheatsheet tool for the command-line
# navi repo add denisidoro/cheats


## Upgrade packages and remove unecessary ones
sudo apt -y upgrade
sudo apt -y autoremove


## Configure flameshot as the default action for PrtScn key
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


## Configure git
bash config_git.sh

## Configure themes
bash install_themes.sh
