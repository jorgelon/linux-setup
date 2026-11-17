# WUCHANG: Fallen Feathers

Priority: stable framerate at 3440x1440 on the AW3423DWF (165Hz).

See [tunning.md](tunning.md) for the general Proton-CachyOS / DXVK / gaming.conf setup this builds on.

## Proton

- Proton-CachyOS runs it fine — Linux users on CachyOS report no performance difference vs GE-Proton 10-10, so the global per-game default from tunning.md applies as-is, no override needed.
- If the game fails to boot on the standard executable, switch the launch executable to the **"Deck-Shipping"** build (Properties > alternate executable) — some Linux users hit a boot hang on the regular Win64 exe.

## Advanced Graphics settings

| Setting | Values | Recommended | Notes |
|---|---|---|---|
| Upscaling (Super Resolution) | Off/FSR/DLSS | DLSS | Use DLSS on this Nvidia card |
| Oversampling Resolution | slider | ~60-67% (Quality) | 3440x1440 is ~2.4x the pixels of 1080p; RTX 3060 Ti 1080p-native numbers (~75fps) won't hold here without upscaling |
| Texture Quality | Low → Ultra | Mid-High | VRAM-bound not fps-bound, 8GB handles it free |
| Shadow Quality | Low → Ultra | Ultra | Reported cheap on this engine |
| Global Illumination | Low → Ultra | Low | Biggest single fps cost, ~10fps per community reports |
| Volumetric Fog | Low → Ultra | Low | Second biggest fps cost |
| Reflection Quality | Low → Ultra | Medium | |
| Vegetation Quality | Low → Ultra | Medium | |
| Ambient Occlusion | Low → Ultra | High | Cheap |
| Post Processing | Low → Ultra | High | Cheap |
| Effects Quality | Low → Ultra | High | Cheap |
| Anti-Aliasing | Low → High | High | |
| Sharpening | slider | ~2 | |
| Motion Blur | On/Off | Off | Stutter-fix guides recommend disabling |
| Depth of Field | On/Off | Off | Stutter-fix guides recommend disabling |
| Frame Generation | On/Off | Off, test carefully | Engine handles fluctuating framerate badly; multiple community threads report frame gen causing stutter |

## Stutter mitigation

- The engine doesn't tolerate a fluctuating framerate well — spikes/drops read as stutter even when average fps is fine.
- Set an **in-game FPS cap near your sustained average**, not your ceiling (e.g. if you average 70fps, cap at 60). The global `dxvk.conf` 160 cap from tunning.md exists for G-Sync range headroom, not for smoothing this game's specific stutter — treat it as a ceiling, not a target.
- Keep DLSS below 100% (i.e. avoid DLAA) — reportedly no visual difference vs 99% but a real fps cost.

## DLSS preset

The global `gaming.conf` forces `DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION=RENDER_PRESET_K`. A community engine-tweak mod for this specific game instead forces Preset L. Couldn't verify which is actually better for this title — if DLSS ghosting/smearing shows up, worth an in-game A/B, but don't override the global default speculatively.

## Links

- https://www.protondb.com/app/2277560
- https://steamcommunity.com/app/2277560/discussions/0/600784815203156405/
- https://deltiasgaming.com/best-settings-for-wuchang-fallen-feathers-rtx-3060-ti/
- https://pcoptimizedsettings.com/wuchang-fallen-feathers-settings-for-low-end-pc-laptops-rtx-3060-3060-ti-rtx-4060-4060-ti/
- https://gametyrant.com/news/pc-settings-with-no-stuttering-for-wuchang-fallen-feathers
- https://steamcommunity.com/app/2277560/discussions/0/600784815203156722/
