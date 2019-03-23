#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/usr/local/bin/brew update
/usr/local/bin/brew upgrade
brew install bluetoothconnector
brew install switchaudio-osx
cd $TMPDIR && curl -OL "https://github.com/ptts/alfred-airpods/raw/master/AirPods.alfredworkflow"
cd $TMPDIR && open -a "/Applications/Alfred 3.app" "$TMPDIR"AirPods.alfredworkflow
# cd $TMPDIR && rm AirPods.alfredworkflow
echo "All done."
