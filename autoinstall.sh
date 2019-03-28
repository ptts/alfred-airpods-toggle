#!/usr/bin/env bash

function _exists {
    if [[ $(command -v "$1") == "" ]]; then
        return 1
    else
        return 0
    fi;
}

function log() { # $1 = string
    COLOR='\033[1;33m'
    NC='\033[0m'
    printf "${COLOR}$1${NC}\n"
}

function log_success() { # $1 = string
    COLOR='\033[0;32m'
    NC='\033[0m'
    printf "${COLOR}$1${NC}\n"
}

function log_error() { # $1 = string
    COLOR="\033[0;31m"
    NC='\033[0m'
    printf "${COLOR}$1${NC}\n"
}


log "This script will install the Alfred workflow 'AirPods Toggle‘ and all required dependencies. (if necessary)"
read -p "Press enter to continue...\n"

echo
if _exists brew; then
    log_success "[✓] Homebrew already installed. Updating.. "
    brew update
    brew upgrade
else
    log "[...] Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [ $? -eq 0 ]; then
        log_success "[✓] Homebrew successfully installed."
    else
        log_error "[X] Homebrew installation failed. Abort."
        exit 1
    fi
fi;

if _exists bluetoothconnector; then
    log_success "[✓] bluetoothconnector already installed."
else
    log "[...] Installing bluetoothconnector"
    brew install bluetoothconnector
    if [ $? -eq 0 ]; then
        log_success "[✓] bluetoothconnector successfully installed."
    else
        log_error "[X] bluetoothconnector installation failed. Abort."
        exit 1
    fi
fi;

if _exists SwitchAudioSource; then
    log_success "[✓] switchaudio-osx already installed"
else
    log "[...] Installing switchaudio-osx"
    brew install switchaudio-osx
    if [ $? -eq 0 ]; then
        log_success "[✓] switchaudio-osx successfully installed."
    else
        log_error "[X] switchaudio-osx installation failed. Abort."
        exit 1
    fi
fi;

if _exists SwitchAudioSource && _exists SwitchAudioSource && _exists SwitchAudioSource; then
    log_success "[✓] All requirements installed"
    log "[...] Installing workflow"
    cd $TMPDIR
    curl -Ls "https://github.com/ptts/alfred-airpods-toggle/raw/master/AirPods%20Toggle/source/AirPods%20Toggle.alfredworkflow" > "$TMPDIR""AirPods Toggle.alfredworkflow"
    open -a "/Applications/Alfred 3.app" "$TMPDIR""AirPods Toggle.alfredworkflow"
    if [ $? -eq 0 ]; then
        log_success "[✓] AirPods Workflow successfully installed."
        log_success "[✓] ALL DONE"
    else
        log_error "[X] AirPods Workflow installation failed. Abort."
        exit 1
    fi
else
    log_error "[X] Installation failed. Requirements not found."
fi;
