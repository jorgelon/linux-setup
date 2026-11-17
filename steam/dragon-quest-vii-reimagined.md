# DRAGON QUEST VII Reimagined

Steam appid `2499860`. Unreal Engine 4.

Priority: native 3440x1440 on the AW3423DWF (21:9).

See [tunning.md](tunning.md) for the general Proton-CachyOS / DXVK / gaming.conf setup this builds on.

## Ultrawide resolution

The game has no native ultrawide support: even with `ResolutionSizeX=3440` / `ResolutionSizeY=1440` in its config and Proton setting the display mode to `3440x1440@165`, the game won't render at 21:9.

Fix: [DQ7RFix](https://codeberg.org/Lyall/DQ7RFix) by Lyall (version 0.0.5), an ASI plugin that adds support for any aspect ratio, a scaled 16:9 HUD and custom resolution support.

1. Download `DQ7RFix_<version>.zip` from the [releases](https://codeberg.org/Lyall/DQ7RFix/releases)
2. Extract `dsound.dll`, `DQ7RFix.asi` and `DQ7RFix.ini` into the shipping executable folder:

   ```
   ~/.local/share/Steam/steamapps/common/DQ7R/DQ7R/Binaries/Win64/
   ```

3. Steam launch options (the `dsound` override is needed so Proton loads the ASI loader instead of its builtin `dsound.dll`):

   ```
   WINEDLLOVERRIDES="dsound=n,b" gamemoderun mangohud %command%
   ```

4. In game, set fullscreen at 3440x1440

`DQ7RFix.ini` defaults are fine as-is:

| Section | Default | Notes |
|---|---|---|
| Custom Resolution | `Enabled = true`, `Width/Height = 0` | 0 = use the desktop resolution (3440x1440) |
| Fix Aspect Ratio | `Enabled = true` | |
| Fix HUD | `Enabled = true`, `Span = false` | `Span = true` stretches the field/battle HUD to the screen edges |
| Disable Cutscene Letterboxing | `Enabled = false` | Optional |

If the fix is working, a `DQ7RFix.log` file appears next to the game `.exe` after launch.

## Files

Paths relative to `~/.local/share/Steam/steamapps/compatdata/2499860/pfx/drive_c/users/steamuser/`:

- Settings: `AppData/Local/DQ7R/Saved/Config/WindowsNoEditor/GameUserSettings.ini`
- Saves: `Documents/My Games/DRAGON QUEST VII/Steam/<steamid>/release/Saved/SaveGames/`

## Render scale

The first launch auto-detected `sg.ResolutionQuality=50` (50% render scale) in `GameUserSettings.ini`, so the game renders at half resolution and upscales. Raise the resolution scale in the in-game graphics settings.

## Links

- https://codeberg.org/Lyall/DQ7RFix
- https://www.protondb.com/app/2499860
