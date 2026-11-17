# Tainted Grail: The Fall of Avalon

Priority: stable framerate at 3440x1440 on the AW3423DWF (165Hz).

See [tunning.md](tunning.md) for the general Proton-CachyOS / DXVK / gaming.conf setup this builds on.

## Engine

- Unity (IL2CPP), runs as **DirectX 11 through DXVK** under Proton — the global `dxvk.conf` 160fps cap applies.
- DLSS is supported in-game (ships `nvngx_dlss.dll`); the global Preset K override from `gaming.conf` applies.

## Proton

- Compatibility: `proton-cachyos-slr` (Properties > Compatibility). ProtonDB rates it platinum, works out of the box.
- Launch options: `gamemoderun mangohud %command%`
- Use the Windows build through Proton, not the native Linux build — users report crashes and missing textures on the native one.

## Graphics settings

| Setting | Values | Recommended | Notes |
|---|---|---|---|
| Fullscreen | Fullscreen / Windowed | Fullscreen (borderless) | |
| Target FPS | slider / Unlimited | Unlimited | Global `dxvk.conf` cap at 160 keeps it inside G-Sync range |
| V-Sync | On/Off | Off | G-Sync handles tearing |
| Motion Blur | On/Off | Off | |
| Dynamic Resolution (upscaling) | Off/STP/FSR/DLSS | DLSS | Use DLSS on this Nvidia card |
| Dynamic Quality % | slider | 65-75% | 3440x1440 needs upscaling on a 3060 Ti; Preset K keeps 65% sharp. Raise only with fps headroom |
| Texture Quality | Half/Full | Full | Fits in 8GB VRAM |
| View Distance | slider | High | Lower to ~75% if under 60fps |
| Mipmaps Bias | slider | 75-100% | Affects distant objects; lower if under 60fps |
| Vegetation | Low/High | Medium | One of the first settings to lower for fps |
| VFX Quality | Low/High | Medium-High | |
| Fog Quality | Low/Medium/High | Low | Most expensive setting, fog effects stack and tank fps |
| Shadows | On/Off | On | |
| Shadow Distance | slider | 70-80% | |
| Contact Shadows | On/Off | On | |
| Subsurface Scattering | On/Off | On | |
| SSS Quality | Low/Medium/High | Medium | |
| SSAO | On/Off | On | |
| Depth of Field | On/Off | Off | Preference |
| Chromatic Aberration | On/Off | Off | Preference |
| Lens Flare | On/Off | Off | Preference |

## Notes

- Benchmark outdoors — dungeons run much faster and give misleading numbers.
- Save/load outside dense fog areas to avoid stutter.
- The "frametime spike every ~2 seconds" reported on the CachyOS forum is a laptop battery-polling issue, not relevant on this desktop.
- `PROTON_LOG=1` (global in `gaming.conf`) wrote a ~478MB log in a single 3h session of this game. Logging that heavy can cause stutter.
- Settings are stored in `compatdata/1466060/pfx/drive_c/users/steamuser/AppData/LocalLow/Questline/Fall of Avalon/<steamid>/Unsynchronized/PlayerPrefs.data` (JSON).

## Links

- https://www.protondb.com/app/1466060
- https://discuss.cachyos.org/t/i-am-having-a-frametime-issue-with-tainted-grail-fall-of-avalon/24764
- https://blast.tv/gaming/news/tainted-grail-the-fall-of-avalon-optimized-settings
- https://gamerblurb.com/articles/best-graphics-settings-for-tainted-grail-the-fall-of-avalon
- https://thebackdash.com/tech/best-tainted-grail-the-fall-of-avalon-pc-settings/
- https://en.gamegpu.com/test-gpu/action-fps-tps/tainted-grail-the-fall-of-avalon-test-gpu-cpu
