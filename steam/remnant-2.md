# Remnant 2

Priority: stable framerate at 3440x1440 on the AW3423DWF (165Hz).

See [tunning.md](tunning.md) for the general Proton / DXVK / gaming.conf setup this builds on.

## Engine

- Unreal Engine 5, runs as **DirectX 12 through VKD3D-Proton** under Proton.
- The global `dxvk.conf` 160fps cap does **not** apply (DXVK is not used) — the frame cap must be set in-game.
- Ships DLSS 3.7.20; `PROTON_DLSS_UPGRADE=1` upgrades it at launch and the global Preset K override from `gaming.conf` applies (Proton log shows `Override DLSS-SR presets = 0xb`).
- DLSS Frame Generation (DLSS-G) is in the menu but needs an RTX 40-series card — not usable on the 3060 Ti.

## Proton

- Compatibility: **Proton Experimental** (Properties > Compatibility).
- `proton-cachyos-slr` (cachyos-11.0-20261015) **does not work**: the game exits ~12s after launch with no exception in the Proton log, no kernel/NVIDIA error and no UE crash report. Proton Experimental (experimental-11.0-20261112) runs it cleanly.
- Launch options: `gamemoderun mangohud %command%`
- `vm.max_map_count` is already 1048576 on this system (the value community reports use to fix crashes on load).

## Graphics settings

| Setting | Recommended | Notes |
|---|---|---|
| Fullscreen | Fullscreen | |
| Frame Rate Limit | 160 | Only cap available (VKD3D, no `dxvk.conf`). Keeps it inside the G-Sync range. Lower it toward your sustained average if frametimes are uneven |
| V-Sync | Off | G-Sync handles tearing |
| NVIDIA Reflex | On | Supported by VKD3D-Proton |
| Upscaler | DLSS | Game is built around upscaling; poor performance without it |
| Upscaler quality | Balanced–Quality (~58–67%) | Currently `sg.ResolutionQuality=60` |
| Frame Generation | Off | Not available on RTX 30-series |
| Shadow Quality | Low–Medium | Most expensive setting, lower first |
| Foliage Quality | Low–Medium | |
| Effects Quality | Medium | |
| Post Processing | High | Cheap |
| Other quality settings | Medium | Starting point; raise with fps headroom |

## Notes

- Settings live in `compatdata/1282100/pfx/drive_c/users/steamuser/AppData/Local/Remnant2/Saved/Config/Windows/GameUserSettings.ini` (CRLF line endings). The game and Steam Cloud rewrite it, so set the frame cap and Reflex **from the in-game menu**, not by editing the file.
- Steam's `config.vdf` / `localconfig.vdf` (Proton mapping, launch options) are rewritten by a running Steam — quit Steam before editing them by hand, or use the Steam UI.

## Links

- https://www.protondb.com/app/1282100
- https://steamcommunity.com/app/1282100/discussions/0/3809533247350792394
- https://www.gamingonlinux.com/2024/03/vkd3d-proton-version-212-adds-nvidia-reflex-support/page=1/
- https://sportskeeda.com/gaming-tech/best-remnant-2-graphics-settings-rtx-3060-rtx-3060-ti
- https://exputer.com/guides/settings/remnant-2-best-settings/
- https://www.techpowerup.com/review/remnant-2-benchmark-test-performance-analysis/single-page.html
