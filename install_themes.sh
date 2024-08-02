#!/bin/bash
# Created by: George Araújo (george.gcac@gmail.com)
# Currently for Ubuntu 24.04 (Noble Numbat)

## Install commands to use
ADD_APT_REPO="sudo add-apt-repository -y"
APT_INSTALL="sudo apt install -y"
CONKY_THEMES_DIR="$HOME/.config/conky"
# FLATPAK_INSTALL="flatpak install"
GIT_CLONE="git clone --depth 1"
GIT_THEMES_DIR="$HOME/.themes_git"
GSET="gsettings set"
ICONS_DIR="$HOME/.icons"
SNAP_INSTALL="sudo snap install"
THEMES_DIR="$HOME/.themes"
USR_DL="$HOME/Downloads"
USR_FONTS="$HOME/.fonts"


## Auxiliary functions
. install_functions.sh


## Create themes and icons folder
# mkdir -p $GIT_THEMES_DIR
mkdir -p $ICONS_DIR
mkdir -p $THEMES_DIR


## Installs via apt
sudo apt update -y
# $APT_INSTALL conky-all
# $APT_INSTALL flatpak # to install 
# $APT_INSTALL gnome-software-plugin-flatpak gnome-software
$APT_INSTALL gnome-tweaks
# $APT_INSTALL jq # needed by conky scripts to read json data
# $APT_INSTALL lua5.4 # needed by conky scripts
$APT_INSTALL variety # wallpaper rotator


## Download Nerd Fonts for usage with Starship
mkdir -p $USR_FONTS
mkdir -p $USR_DL

site=$(get_latest_github_release_no_v "ryanoasis/nerd-fonts" "Ubuntu.zip")
aria2c -c --summary-interval 0 -d $USR_DL $site
unzip -u $USR_DL/Ubuntu.zip -d $USR_FONTS
rm $USR_DL/Ubuntu.zip

site=$(get_latest_github_release_no_v "ryanoasis/nerd-fonts" "UbuntuMono.zip")
aria2c -c --summary-interval 0 -d $USR_DL $site
unzip -u $USR_DL/UbuntuMono.zip -d $USR_FONTS
rm $USR_DL/UbuntuMono.zip

## Themes for softwares
# gitk dracula theme
aria2c -c --summary-interval 0 -d $USR_DL https://github.com/dracula/gitk/archive/master.zip
unzip -u $USR_DL/gitk-master.zip
cp ~/.config/git/gitk ~/.config/git/gitk_bak
cp $USR_DL/gitk-master/gitk ~/.config/git/
rm $USR_DL/gitk-master.zip
rm -rf $USR_DL/gitk-master/


## Configure Gnome3 settings
# https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en
ICON_THEME="Yaru-blue-dark"
THEME="Yaru-blue-dark"

$GSET org.gnome.desktop.interface clock-show-date true
$GSET org.gnome.desktop.interface clock-show-weekday true
$GSET org.gnome.desktop.interface color-scheme 'prefer-dark'
$GSET org.gnome.desktop.interface gtk-theme $THEME
$GSET org.gnome.desktop.interface icon-theme $ICON_THEME
$GSET org.gnome.desktop.interface show-battery-percentage true
$GSET org.gnome.desktop.peripherals.mouse natural-scroll true
# $GSET org.gnome.desktop.wm.preferences theme $THEME
$GSET org.gnome.settings-daemon.plugins.color night-light-enabled true
$GSET org.gnome.shell.extensions.dash-to-dock click-action 'minimize'


## Install and configure Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
cp starship.toml $HOME/.config/
$GSET org.gnome.desktop.interface monospace-font-name 'UbuntuMono Nerd Font Mono 12'

