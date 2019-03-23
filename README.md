# alfred-airpods


# Install
1. If you haven't already, install Homebrew:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
2. install required packages
```
brew install bluetoothconnector
brew install switchaudio-osx
```
3. Download & Install Workflow
```
cd $TMPDIR && curl -OL "https://github.com/ptts/alfred-airpods/raw/master/AirPods.alfredworkflow" && open -a "/Applications/Alfred 3.app" "$TMPDIR"AirPods.alfredworkflow
```

# Auto Install
You can autoinstall all requirements and the Workflow itself by pasting the following code into your Terminal:
```
bash <(curl -s https://raw.githubusercontent.com/ptts/alfred-airpods/master/autoinstall.sh)
```
WARNING: Do this at your own risk and check out the script before you run it.

# Requirements
- Homebrew
- BluetoothConnector
- SwitchAudioSource

