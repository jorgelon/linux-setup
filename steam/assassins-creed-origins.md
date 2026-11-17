# Assassin's Creed Origins

Priority: stable ~60-80 fps at 3440x1440 on the AW3423DWF (165Hz), smoothed by G-Sync.

See [tunning.md](tunning.md) for the general Proton-CachyOS / DXVK / gaming.conf setup this builds on.

DX11 game (runs through DXVK), no DLSS. CPU-heavy in cities (Alexandria) on top of Denuvo + VMProtect, so the i5-12400F sets the ceiling as much as the GPU.

## Steam

- Compatibility: `proton-cachyos-slr` (Properties > Compatibility)
- Launch options: `gamemoderun mangohud %command%`

## Graphics settings

| Setting | Recommended | Notes |
|---|---|---|
| Window mode | Fullscreen | |
| Resolution / Refresh | 3440x1440 / 165Hz | |
| VSync | Off | G-Sync + DXVK `maxFrameRate = 160` handle tearing |
| Framerate cap | Unlimited | DXVK cap already applies |
| Adaptive Quality | Off | Avoids resolution swimming |
| Resolution Scale | 100% | Drop to 90% only if fps < 55 in Alexandria |
| Anti-Aliasing | High | Temporal AA, cleans foliage shimmer, cheap |
| Shadows | High | Very High/Ultra cost ~10-15% for little gain |
| Environment Detail | High | Very High+ is CPU-bound in cities |
| Texture Detail | High | Fits 8GB VRAM at 3440x1440 |
| Tessellation | High | |
| Terrain | High | |
| Clutter | High | |
| Fog | Medium | One of the biggest costs, Medium looks nearly identical |
| Water | High | |
| Screen Space Reflections | High | |
| Volumetric Clouds | Off | Biggest single GPU cost |
| Character | High | |
| Character Texture | High | |
| Ambient Occlusion | High (HBAO+) | |
| Depth of Field | On | Cutscenes only |
| Bloom | On | Taste |
| Motion Blur | Off | Taste |

With headroom (steady > 75 fps in mangohud): raise Volumetric Clouds → On first, then Shadows → Very High.
If short: lower Fog → Low, then Environment Detail → Medium.

## Config file

Settings are stored in the prefix at `compatdata/582160/pfx/drive_c/users/steamuser/Documents/Assassin's Creed Origins/ACO.ini` (`[Graphics]` section). Change quality values from the in-game menu, not by hand: the ini numeric indices are undocumented.

## Verification

Built-in benchmark (Options > Graphics > Benchmark): target average 65+ fps, minimum 45+ fps.
