# Gaming steam

## Concepts

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

## Kernel

CachyOS ships multiple kernel variants (`linux-cachyos`, `-bore`, `-bmq`, `-eevdf`, `-lts`, `-hardened`, `-rt-bore`, `-server`, `-deckify`...), all built on the CachyOS Base Patchset.

Recommended: **`linux-cachyos`** (the default variant, already in use on this machine).

- Wiki explicitly calls it "the recommended kernel if you're unsure which one to use".
- Only variant profiled with AutoFDO + Propeller (real workload profiling data used for codegen optimization).
- Built with Clang + ThinLTO, 1000Hz tickrate, includes the POC idle-CPU selector for lower wakeup latency.
- Ships precompiled NVIDIA kernel modules (relevant for the RTX 3060 Ti).
- Already includes selectable BORE/EEVDF/BMQ schedulers, so no need for the separate `-bore`/`-bmq`/`-eevdf` packages just to try them.
- No need for `-rt-bore`: CachyOS' own FAQ says the realtime kernel does **not** improve gaming performance (more preemption hurts it).

Further tuning: CachyOS Kernel Manager / `game-performance` wrapper can switch to a sched-ext "Gaming" scx scheduler profile + performance governor on top of this kernel while gaming, without needing to change kernel variant.

https://wiki.cachyos.org/features/kernel/

## Proton CachyOS

CachyOS implementation of Proton introducing experimental features, third-party tools and more.

https://github.com/CachyOS/proton-cachyos

- Selection

Go to Steam > Settings > Compatibility, check the box to enable Steam Play for all titles, and set your default tool to Proton-CachyOS.

In cachyos can be configured globally under

```shell
cd /usr/share/steam/compatibilitytools.d/proton-cachyos-slr/
cp user_settings.sample.py user_settings.py
vi user_settings.py
```


```txt
other
PROTON_NVIDIA_LIBS=1: Enable Nvidia libraries (PhysX, CUDA) - not needed for DLSS/ray tracing
```
### Disable Shader Pre-Caching 

- Disable

CachyOS and Proton handle shader compilation natively, and this prevents stuttering. Open Steam and go to Steam > Settings > Downloads.Scroll to the bottom and disable Shader Pre-Caching


```shell
mkdir -p ~/.config/environment.d
echo "__GL_SHADER_DISK_CACHE_SIZE=12000000000" > ~/.config/environment.d/gaming.conf
```

### gaming.conf (NVIDIA RTX 3060 Ti)

Global env vars applied to every game, set in `~/.config/environment.d/gaming.conf`:

```txt
__GL_SHADER_DISK_CACHE_SIZE=12000000000
__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
DXVK_CONFIG_FILE=${HOME}/.config/dxvk/dxvk.conf
DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION=RENDER_PRESET_K
PROTON_DLSS_INDICATOR=1
PROTON_DLSS_UPGRADE=1
PROTON_LOG=1
```

- `__GL_SHADER_DISK_CACHE_SIZE=12000000000`: raise Nvidia's shader disk cache to 12GB, avoids re-compiling shaders on large games (official CachyOS recommendation).
- `__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1`: stop the driver from pruning the shader cache, pairs with the increased size above.
- `DXVK_CONFIG_FILE`: points DXVK at the shared per-system config at `~/.config/dxvk/dxvk.conf`.
- `DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION=RENDER_PRESET_K`: forces the newer transformer-model DLSS preset (Preset K) in games that don't expose it yet.
- `PROTON_DLSS_INDICATOR=1` / `PROTON_DLSS_UPGRADE=1`: show a DLSS status overlay and auto-upgrade DLSS to the latest shipped version.
- `PROTON_LOG=1`: enable Proton logging (useful for troubleshooting, minor overhead when always-on).

Deliberately kept out of the global file (better as per-game Steam launch options since they're situational, not universally beneficial):

- `PROTON_NVIDIA_NVOPTIX=1` / `PROTON_NVIDIA_LIBS=1`: only needed for specific games using OptiX ray tracing or PhysX/CUDA.
- `PROTON_NVIDIA_LIBS_NO_32BIT=1`: fixes an RTX 4000-series-specific issue, not applicable to the 3060 Ti.
- `PROTON_NO_NTSYNC=1`, `PROTON_ENABLE_WAYLAND=1`, `PROTON_PREFER_SDL=1`: workarounds for specific game bugs.

https://wiki.cachyos.org/configuration/gaming/

## Conclusions

- enable proton-cachyos
- configure ~/.config/dxvk/dxvk.conf
- start steam games with **gamemoderun mangohud %command%**

## Links

- https://wiki.cachyos.org/configuration/gaming/

- https://www.protondb.com/