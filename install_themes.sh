#!/bin/bash
# Created by: George Araújo (george.gcac@gmail.com)
# Currently for Ubuntu 22.04 LTS (Jammy Jellyfish)

## Install commands to use
ADD_APT_REPO="sudo add-apt-repository -y"
APT_INSTALL="sudo apt install -y"
GSET="gsettings set"
USR_DL="$HOME/Downloads"
USR_FONTS="$HOME/.fonts"


## Auxiliary functions
. install_functions.sh


## Adding repos
# Wallpaper rotator
$ADD_APT_REPO ppa:variety/stable


## Installs via apt
sudo apt update -y
$APT_INSTALL conky-all
# $APT_INSTALL flatpak # to install 
# $APT_INSTALL gnome-software-plugin-flatpak gnome-software
$APT_INSTALL gnome-tweaks
$APT_INSTALL jq # needed by conky scripts to read json data
$APT_INSTALL lua5.4 # needed by conky scripts
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


## Configure Gnome3 settings
# https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en
$GSET org.gnome.desktop.interface clock-show-date true
$GSET org.gnome.desktop.interface clock-show-weekday true
$GSET org.gnome.desktop.interface color-scheme 'prefer-dark'
$GSET org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'
$GSET org.gnome.desktop.peripherals.mouse natural-scroll true
$GSET org.gnome.desktop.interface show-battery-percentage true
$GSET org.gnome.settings-daemon.plugins.color night-light-enabled true
$GSET org.gnome.shell.extensions.dash-to-dock click-action 'minimize'


## Install and configure Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
cp starship.toml $HOME/.config/
$GSET org.gnome.desktop.interface monospace-font-name 'UbuntuMono Nerd Font Mono 12'
