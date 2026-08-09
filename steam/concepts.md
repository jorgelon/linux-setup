# Gaming steam concepts

- Lutris
  
It is a game launcher on CachyOS

- DXVK

Vulkan-based translation layer that converts Direct3D 9/10/11 calls into Vulkan calls

https://github.com/doitsujin/DXVK

- Mangohud
  
It is an open-source performance overlay for Linux

- dlss-swapper

Tool that allows you to download, manage, and swap DLSS, FSR and XeSS dlls allowing you to upgrade or downgrade DLSS, FSR and XeSS version in a game without the game needing an update.

https://github.com/beeradmoore/dlss-swapper

## Gamemoderun and game-performance

They are 2 commands that put the computer in performance mode. 

gamemoderun (feralinteractive) configures more things than game-performance (cachyos) and it can be installed with

```txt
sudo pacman -S gamemode lib32-gamemode
```

https://github.com/feralinteractive/gamemode

They can be enable at steam level (as advanced command)

```txt
gamemoderun %command%
game-performance %command%
```
