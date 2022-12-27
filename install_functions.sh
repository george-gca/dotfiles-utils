#!/bin/bash
get_latest_github_release() {
  # use it for when the link for the download has a version included in the name of the file
  # e.g.: version 0.14.0 for https://github.com/dandavison/delta/releases/download/0.14.0/git-delta_0.14.0_amd64.deb
  # usage: get_latest_release "user/repo" "prefix" "suffix"
  version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" |  # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
  version_no_v=$(echo $version | sed -e "s/v//g")
  echo "https://github.com/$1/releases/download/$version/"$2"$version_no_v"$3
}

get_latest_github_release_no_v() {
  # use it for when the link for the download doesn't have a version included in the name of the file
  # e.g.: https://github.com/dbrgn/tealdeer/releases/download/v1.6.1/tealdeer-linux-x86_64-musl
  # usage: get_latest_release "user/repo" "filename"
  version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" |  # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
  echo "https://github.com/$1/releases/download/$version/"$2
}

get_latest_github_raw_no_v() {
  # use it for when the link for the download doesn't have a version included in the name of the file
  # e.g.: https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
  # usage: get_latest_github_raw_no_v "user/repo" "filename"
  version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" |  # Get latest release from GitHub api
    grep '"tag_name":' |                                             # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
  echo "https://raw.githubusercontent.com/$1/$version/"$2
}

