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