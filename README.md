# dotfiles-utils

A collection of scripts and configuration files I use in my PC.

## Scripts

Most of them are under [bin](bin/) directory. The rest here is not supposed to be available system wide.

### backup_phone_chrome_tabs.sh

Create a file with all open links in the chrome browser in your android phone. For this to work, you must:

1. install adb: `sudo apt install adb`
1. enable debug mode in your phone
1. connect your phone with your computer via usb
1. accept connections from this host (your pc)
1. open chrome in phone
1. run this script

### config_git.sh

Install and configure `git`, creating aliases and settings.

### install_basic.sh

Install the basic stuff I use on my pc as much as non-interactive as possible (only need to interact to provide sudo password and accept usage of Microsoft fonts). It calls internally `config_git.sh` and `install_themes.sh`.

### install_themes.sh

Install and configure my setup with some customization tools.

## Configuration Files

I prefer to set my configuration files more manually, than to do a [bare git setup](https://www.atlassian.com/git/tutorials/dotfiles). Currently I only use these configuration files:
- .bash_aliases
- .bash_completion
- .bashrc
- .inputrc
- .nanorc

All the information inside is commented (for remembering sake).
