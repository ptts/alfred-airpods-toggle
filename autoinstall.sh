#!/bin/bash

# Install Homebrew
if [[ $(command -v brew) == "" ]]; then
        echo "[...] Installing Homebrew.. "
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "[✓] Homebrew already installed. Updating.. "
        brew update
        brew upgrade
fi;

# Install requirements
if [[ $(command -v bluetoothconnector) == "" ]]; then
        echo "[...] Installing bluetoothconnector.. "
        brew install bluetoothconnector
    else
        echo "[✓] bluetoothconnector already installed."
fi;

if [[ $(command -v SwitchAudioSource) == "" ]]; then
        echo "[...] Installing switchaudio-osx.. "
        brew install switchaudio-osx
        echo "[✓] switchaudio-osx installed"
    else
        echo "[✓] switchaudio-osx already installed"
fi;

# Install workflow
if [[ ! $(command -v brew) == "" ]] && [[ ! $(command -v bluetoothconnector) == "" ]] && [[ ! $(command -v SwitchAudioSource) == "" ]]; then
    echo "[✓] All requirements installed"
    echo "[...] Installing workflow..."
    cd $TMPDIR
    curl -OLs "https://github.com/ptts/alfred-airpods/raw/master/AirPods.alfredworkflow" && open -a "/Applications/Alfred 3.app" "$TMPDIR"AirPods.alfredworkflow
    echo "[✓] DONE. Workflow installed"
else
    echo "[X] Installation failed. Requirements not found."
fi;


