#!/bin/bash
# Created by: George Araújo (george.gcac@gmail.com)
# Currently for Ubuntu 22.04 LTS (Jammy Jellyfish)

## Install commands to use
ADD_APT_REPO="sudo add-apt-repository -y"
APT_INSTALL="sudo apt install -y"
GIT_CONFIG="git config --global"
USR_BIN="$HOME/bin"


## Adding repos
# Git Latest Releases
$ADD_APT_REPO ppa:git-core/ppa


## Installs via apt
sudo apt update -y
$APT_INSTALL git
$APT_INSTALL gitk


## Configure git
# $GIT_CONFIG user.name ""
# $GIT_CONFIG user.email ""

$GIT_CONFIG alias.branches  'branch -a'
$GIT_CONFIG alias.casm      'commit -a -s -m'
$GIT_CONFIG alias.csm       'commit -s -m'
$GIT_CONFIG alias.lol       'log --graph --decorate --pretty=oneline --abbrev-commit --all'
$GIT_CONFIG alias.lsignored 'ls-files . --ignored --exclude-standard --others'
$GIT_CONFIG alias.pr        'pull --rebase'
$GIT_CONFIG alias.remotes   'remote -v'
$GIT_CONFIG alias.rh        'reset --hard'
$GIT_CONFIG alias.st        'status -sb'
$GIT_CONFIG alias.stu       'status -sbuno'
$GIT_CONFIG alias.tags      'tag -l'

$GIT_CONFIG color.ui true
$GIT_CONFIG color.diff.commit     "yellow bold"
$GIT_CONFIG color.diff.frag       "magenta bold"
$GIT_CONFIG color.diff.meta       "11"
$GIT_CONFIG color.diff.new        "green bold"
$GIT_CONFIG color.diff.old        "red bold"
$GIT_CONFIG color.diff.whitespace "red reverse"
$GIT_CONFIG color.diff-highlight.newHighlight "green bold 22"
$GIT_CONFIG color.diff-highlight.newNormal    "green bold"
$GIT_CONFIG color.diff-highlight.oldHighlight "red bold 52"
$GIT_CONFIG color.diff-highlight.oldNormal    "red bold"
$GIT_CONFIG color.status.added      "green"
$GIT_CONFIG color.status.changed    "yellow"
$GIT_CONFIG color.status.deleted    "red"
$GIT_CONFIG color.status.untracked  "cyan"

$GIT_CONFIG merge.tool "meld"

$GIT_CONFIG pager.diff      "delta"
$GIT_CONFIG pager.log       "delta"
$GIT_CONFIG pager.reflog    "delta"
$GIT_CONFIG pager.show      "delta"

$GIT_CONFIG delta.line-numbers "true"
$GIT_CONFIG delta.side-by-side "true"

$GIT_CONFIG push.default "simple"
