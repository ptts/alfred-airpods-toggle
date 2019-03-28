# alfred-airpods-toggle

A smart workflow that toggles the connection to your AirPods with *no setup required*.

Download: [Download current version](https://github.com/ptts/alfred-airpods-toggle/blob/master/AirPods%20Toggle/source/AirPods%20Toggle.alfredworkflow?raw=true)

![Alfred Smart AirPods Toggle](https://github.com/ptts/alfred-airpods-toggle/blob/master/images/alfred_airpods.gif)

### Requirements
- Homebrew
- BluetoothConnector
- SwitchAudioSource

### Install
1. If you haven't already, install Homebrew:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
2. Install required packages
```
brew install bluetoothconnector
brew install switchaudio-osx
```
3. Download & Install the Workflow
```
cd $TMPDIR && curl -OL "https://github.com/ptts/alfred-airpods-toggle/blob/master/AirPods%20Toggle/source/AirPods%20Toggle.alfredworkflow?raw=true" && open -a "/Applications/Alfred 3.app" "$TMPDIR""/AirPods Toggle.alfredworkflow.alfredworkflow"
```
Or manually by downloading the workflow [here](https://github.com/ptts/alfred-airpods-toggle/blob/master/AirPods%20Toggle/source/AirPods%20Toggle.alfredworkflow?raw=true).

#### Auto Install
![Auto Install](https://raw.githubusercontent.com/ptts/alfred-airpods-toggle/master/images/auto_install.gif)

You can autoinstall all requirements and the Workflow itself by pasting the following code into your Terminal:
```
bash <(curl -s https://raw.githubusercontent.com/ptts/alfred-airpods/master/autoinstall.sh)
```
**WARNING**: Do this at your own risk and check out [the script](https://raw.githubusercontent.com/ptts/alfred-airpods-toggle/master/autoinstall.sh) before you run it. For me the script also works fine even if you already have homebrew and the two dependencies installed. In this case it will just check for updates and then install the workflow.

### How it works
- First, a python script parses the output of running ```bluetoothconnector``` (which outputs a list of all paired bluetooth devices and their MAC address) using Regex and outputs all connected devices and their corresponding MAC addresses in a dictionary. The first item that contains the string "AirPods" is used for the consequent connection/disconnection process and passed to the bash script.
!['bluetoothconnector' output](https://github.com/ptts/alfred-airpods-toggle/blob/master/images/alfred_bluetoothconnector.jpg)

- The bash script then first checks whether the AirPods are currently used as the system output by using the ```SwitchAudioSource -c``` command.
→ If yes, it switches the audio output to the "Internal Speakers" and mutes the system. (To prevent accidentally disconnecting your AirPods and blasting videos on full volume.
→ If not, the bash script tries to connect to the AirPods using the ```BluetoothConnector --connect``` command and the previously extracted MAC address. 
If they're already connected the script will immediately try to switch the audio output using ```SwitchAudioSource -s```.

- Then it checks whether the connection/switching process was successful by using the  ```SwitchAudioSource -c``` (which returns the currently active audio output device). If the output contains the previously extracted AirPods' name, the process will be regarded as successful.
Otherwise the whole connection/switching procedure will be repeated two more times with a 5 second delay timer to allow the bluetooth connection to be established. By including the delay timer only after the first try the switch works immediately if the AirPods are already connected. 

### To Dos:
- allow user to set whether or not the audio output should be muted after the AirPods' disconnection process
- multi device/AirPods support (feel free to submit PRs to the python or bash script to make that happen)
- multi language support (I guess the script currently doesn't work on non-english system as the audio output isn't called 'Internal Speakers' and the disconnection process will thus fail)
- improve auto install script
