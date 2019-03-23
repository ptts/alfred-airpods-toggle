#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update / Upgrade Homebrew
/usr/local/bin/brew update
/usr/local/bin/brew upgrade

# Install required packages
brew install bluetoothconnector
brew install switchaudio-osx

# Download and install workflow
cd $TMPDIR && curl -OL "https://github.com/ptts/alfred-airpods/raw/master/AirPods.alfredworkflow" && open -a "/Applications/Alfred 3.app" "$TMPDIR"AirPods.alfredworkflow

# DONE
echo "All done."
