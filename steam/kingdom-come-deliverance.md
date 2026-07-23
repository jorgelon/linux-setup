# Kingdom Come: Deliverance (1)

Priority: high, stable framerate at 3440x1440 on the AW3423DWF (165Hz).

See [tunning.md](tunning.md) for the general Proton-CachyOS / DXVK / gaming.conf setup this builds on.

## Advanced Graphics settings

| Setting | Values | Recommended | Notes |
|---|---|---|---|
| Object Quality | Low → Ultra | High | Almost no visual difference between tiers, safe to keep high |
| Weather/Game Effects | Low → Ultra | Medium | Minimal visible difference |
| Lighting Quality | Low → Ultra | Medium | Visible drop from High→Medium, moderate cost |
| Particles | Low → Ultra | Medium | Cheap, little visual difference |
| Physics | Low/Medium/High | Medium | One of the most demanding settings; Low looks noticeably worse |
| Postprocess Quality | Low → Ultra | Medium | Minimal visible difference |
| Shader Quality | Low → Ultra | High | Visible loss of surface detail below High |
| Shadows | Low → Ultra | Medium | Biggest single fps cost in the game |
| Textures | Low → Ultra | Very High | VRAM-bound not fps-bound, 8GB handles it free |
| Water Detail | Low → Ultra | Medium | Minimal visible difference |
| Volumetric Effects Detail | Low → Ultra | Medium | Godrays/fog/clouds, modest cost |
| Vegetation Quality | Low → Ultra | Medium-High | Visible density/saturation loss at low |
| Object Distance | slider | ~65% | Objects visibly pop out at low settings |
| LOD Distance | slider | ~50% | Almost no visible difference, safe to keep low-ish |
| Vegetation Draw Distance | slider | ~50% | Moderate cost |
| Motion Blur | Off/Object/Camera | Off | Taste + tiny input-feel benefit |

These 16 are the full Advanced Graphics menu. The game has **no in-menu anti-aliasing option** — AA is controlled only via the `r_AntialiasingMode` console variable in the config, under Proton found at the prefix's `Saved Games\kingdomcome\` folder.

## Anti-aliasing (`r_AntialiasingMode`)

Recommended: **`r_AntialiasingMode = 3`  (SMAA 1Tx)** — temporal SMAA, good edge quality and shimmer reduction for a low performance cost, the right balance for the high-framerate priority above.

- `0` = Off — visible jaggies at 3440x1440, not worth the marginal fps.
- `1` = FXAA — cheapest, but blurs texture detail (works against the High texture/shader settings above).
- `2` = SMAA 1x — spatial only, no temporal shimmer reduction.
- `3` = SMAA 1Tx — **recommended default**.
- `4` = SMAA 2Tx — cleanest edges, better suited to a large 34" panel like the AW3423DWF, but roughly double the AA cost of 1Tx; use if there's fps headroom to spare.
