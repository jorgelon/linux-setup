# Gaming steam

## Concepts

See [concepts.md](concepts.md)

## Settings

1. Kernel: `linux-cachyos` (default variant, already in use on this machine)
2. Proton: keep Valve's official Proton (Experimental) as default under Steam > Settings > Compatibility
3. use `Proton-CachyOS` per-game (Library > game > Properties > Compatibility) for titles that benefit from its extras. Since this is a global (not per-game) Steam setting, also disable Shader Pre-Caching (Steam > Settings > Downloads, uncheck "Allow background processing of Vulkan shaders" and "Enable Shader Pre-caching") — its cached shaders are built for official Proton and conflict with CachyOS/DXVK's native shader compilation on Proton-CachyOS titles
4. Steam launch options (per-game, General > Launch Options): `gamemoderun mangohud %command%`
5. execute `steam/apply-tunning.sh` as root (`sudo steam/apply-tunning.sh`) — configures:
   - `~/.config/environment.d/gaming.conf` (NVIDIA RTX 3060 Ti): 12GB shader disk cache, skip cache cleanup, DXVK config path, forced DLSS Preset K, DLSS indicator/auto-upgrade, Proton logging
   - `~/.config/dxvk/dxvk.conf` (AW3423DWF): `dxvk.maxFrameRate = 160`, caps DXVK games under the monitor's 165Hz max refresh to stay inside G-Sync range
   - disables `ananicy-cpp` permanently — conflicts with `gamemode` over process niceness, and every game launches through `gamemoderun`
   - ADIOS I/O scheduler for the NVMe disk, if the running kernel supports it (e.g. `linux-cachyos`)

## Games

- [Kingdom Come: Deliverance (1)](kingdom-come-deliverance.md)

## Links

- https://wiki.cachyos.org/configuration/gaming/
- https://www.protondb.com/
- https://thenets.org/posts/proton-cachyos-vs-upstream-proton/
