# Tips

# usar bash como shell y no fish


```shell
chsh -s /usr/bin/bash
```

## auto updates

```shell
sudo pacman -S pacman-offline
sudo systemctl enable pacman-offline-prepare.timer
sudo systemctl enable pacman-offline-reboot.timer
```

## printer shown as paused

The HP DeskJet 2600 is a network printer in CUPS with the queue name DeskJet-2600. If the queue gets paused, resume it with:

```shell
cupsenable DeskJet-2600 && cupsaccept DeskJet-2600
```

Check the status with:

```shell
lpstat -p DeskJet-2600 -a DeskJet-2600
```
