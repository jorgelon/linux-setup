# The Surge

Priority: high, stable framerate at 3440x1440 on the AW3423DWF (165Hz) with near-max visuals.

See [tunning.md](tunning.md) for the general Proton / DXVK / gaming.conf setup this builds on.

## Engine

- Deck13 **Fledge** engine (2017), runs as **DirectX 11 through DXVK** under Proton.
- The global `dxvk.conf` 160fps cap **applies**.
- No upscaler (no DLSS/FSR); the AA options are None / FXAA / SMAA (no TAA).
- Light by current standards: the RTX 3060 Ti has plenty of headroom at native 3440x1440.

## Proton

- Compatibility: **proton-cachyos-slr** (CachyOS-11.0-100), runs fine.
- Launch options: `gamemoderun mangohud %command%`
- ProtonDB reports it mostly works out of the box; the reported crashes are on AMD GPUs only.

## Graphics settings

| Setting | Recommended | Notes |
|---|---|---|
| Resolution / refresh | 3440x1440 @ 165Hz | Fullscreen |
| V-Sync | Off | G-Sync handles tearing |
| Max frame rate | 160 | Matches the `dxvk.conf` cap, inside the G-Sync range. If the menu resets it, pick Unlimited — DXVK still caps at 160 |
| Textures | VeryHigh | Fits easily in 8GB VRAM |
| Geometry | VeryHigh | |
| Lighting | VeryHigh | |
| Shadows | High | Most expensive setting; barely distinguishable from VeryHigh. Raise it if there's headroom |
| Volumetric lighting | High | Second most expensive effect |
| Post processing | VeryHigh | |
| Motion blur | Off | |
| Anisotropic filtering | VeryHigh | |
| Anti-aliasing | SMAA | Best option available |
| Logging | false | The game writes ~22k log lines per session (mostly resource unloads) — avoids needless disk I/O |

## Notes

- Settings live in `compatdata/378540/pfx/drive_c/users/steamuser/Documents/The Surge/settings.ini` (CRLF line endings, not synced by Steam Cloud). It can be edited by hand with the game closed. Keys found in the binary that are not in the menu-generated file can be added (e.g. `vsync = Off`, `quality_textures`, `quality_geometry`, `quality_lighting`, `quality_volumetric_lighting`, `quality_postprocessing`).
- The install dir also has a `settings.ini` with defaults; the user one in `Documents` takes precedence.
- Stutter fallback: the Windows release is known to stutter on CPUs with many threads, fixed by restricting CPU affinity. The i5-12400F has 12 threads; only try it if MangoHud shows frametime spikes.

## Links

- https://www.protondb.com/app/378540
- https://re-actor.net/the-surge-stutter-fix-auto-set-cpu-affinity-on-launch/
