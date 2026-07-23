
# UI gnome settings

## Dark mode for Alienware

```shell
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background picture-uri-dark ''
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background color-shading-type 'solid'
```
# show logout

```shell
gsettings set org.gnome.shell always-show-log-out true
```
## show minimize

```shell
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
```