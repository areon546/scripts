# flatpak-command
Simple bash script that creates an exe to run the flatpak in the `~/.local/bin` folder. 

## Setup 

Either:

Copy manually
```sh
cp setupFlatpak.sh ~/.local/bin/setupFlatpak
chmod u+x ~/.local/bin/setupFlatpak
```
This lets you change the name of the command if you want. 

Run make command, same as above. 
```sh
make setup
```

## Example 

Interactively: 
```sh
setupFlatpak
```

Example for setting up: [mission center](https://flathub.org/en/apps/io.missioncenter.MissionCenter). Note, requires the flathub remote to be setup. 
```sh
setupFlatpak -c missionCenter -i io.missioncenter.MissionCenter
```

