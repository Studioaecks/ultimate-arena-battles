# Ultimate Arena Battles

**Transform every Gen1Recomp battle into a dynamic, location-aware, weather-influenced arena experience.**

Inspired by the iconic top-down pixel-art battle animations from the **Pokémon Battlegrounds** YouTube channel (Red vs Gold on Mt. Silver and related shorts), this mod brings free-flowing arena style, Pokédex-accurate giant scaling, full-party auto-progression, and environmental reactivity to Gen1Recomp.

![Banner](https://img.shields.io/badge/Gen1Recomp-Compatible-brightgreen) ![VR](https://img.shields.io/badge/VR-Supported-blue) ![API](https://img.shields.io/badge/Mod%20API-2-orange)

## Features

- **Location-matched battlefields** — Routes become open fields, forests become woodland, gyms become arenas, caves become rocky chambers, indoors become halls, and water becomes open sea. Driven live by the current map.
- **Weather & environmental effects** — Rain boosts Water-type moves and dampens Fire. Integrates with Weather-fx, Kanto Dynamic Weather, or runs its own modifiers. Time-of-day tinting ready.
- **Giant scaling** — Gyarados, Onix, Snorlax, Dragonite and other large species dominate the field with Pokédex-accurate height-based scaling.
- **Auto-party progression** — When the player does not intervene, battles automatically advance through every healthy Pokémon in both parties until a winner is decided.
- **In-battle MENU button** — Bottom-right indicator. Press START to open Switch Pokémon / Use Item / Flee.
- **Flexible sprite sources**:
  - **Custom** — Drop your own PNG sheets into `assets/custom/`
  - **PokePC Followers** — Use the excellent Crystal Clear-style walker sprites
  - **Stadium Extracted** — Use 3D models and effects from your own Pokémon Stadium ROM (via StadiumBattleFX)
- **Full VR compatibility** — Works seamlessly with Dramatic Shape Voxel Mod + VoxelVR (PCVR/OpenXR). Overlay and HUD compose correctly on battle planes. Quest community ports also compatible.

## Inspiration & References

- **Pokémon Battlegrounds** (YouTube) — The top-down free-movement, size-accurate, move-callout battle style that started this project. Special thanks for the Red vs Gold Mt. Silver 6v6 and the community reaction that demanded a playable version.
- **Gen1Recomp** by bryanthaboi — The foundation. Native LÖVE2D recreation of Gen 1/2/3 with a powerful mod API.
- **Dramatic Shape Voxel Mod** + **VoxelVR** — 3D presentation and PCVR support.
- **StadiumBattleFX** / **3D-Pokemon-Sprites** — Stadium model extraction and battle effects (bring your own ROM).
- **PokePC Followers** / **Followers EX** — High-quality overworld walker sprites from the Crystal Clear community.
- **PMD SpriteCollab** — Community sprite sheets (CC BY-NC 4.0).
- **Weather-fx** and related weather mods — Environmental integration points.

## Required / Recommended Mods

| Mod | Purpose | Required? |
|-----|---------|-----------|
| Gen1Recomp | Base engine | Yes |
| Dramatic Shape (DRAMATIC_SHAPE) | 3D battles & presentation | Recommended |
| VoxelVR | PCVR / OpenXR support | Recommended for VR |
| StadiumBattleFX | Stadium models & effects (your own Stadium ROM) | Optional |
| PokePCFollowers / Followers EX | Walker sprite source | Optional |
| Weather-fx / Kanto Dynamic Weather | Advanced weather | Optional |
| Battle Cinematics | Camera direction | Optional |

## Installation

1. Download the latest release zip (or clone this repo).
2. In Gen1Recomp: **MODS → Import mod .zip**.
3. Enable **Ultimate Arena Battles**.
4. (Recommended) Install and enable companion mods listed above. Supply your own Stadium / PMD / Crystal Clear ROM dumps where required — this mod never ships Nintendo assets.
5. For custom sprites: place files in the mod’s `assets/custom/` folder (`species_front.png`, `species_back.png`, or walker sheets).

## Options

Found under **MODS → Ultimate Arena Battles**:

- **SPRITE SOURCE** — Custom Folder / PokePC Followers / Stadium Extracted
- **AUTO BATTLE PARTIES** — Progress full teams automatically when untouched
- **WEATHER EFFECTS** — Enable rain modifiers and environmental reactivity
- **LOCATION FIELD MATCH** — Match battlefield to current map
- **SCALE GIANTS** — Pokédex-height scaling for large species
- **SHOW MENU BUTTON** — Display the bottom-right MENU indicator

## Compatibility

- Gen 1 (Red / Blue / Yellow), Gen 2 (Gold / Silver / Crystal)
- Flat, Dramatic Shape 3D, and VR (VoxelVR) presentations
- Works alongside other battle UI and presentation mods via the public API

## License & Credits

Community effort. Sprites and models are supplied by the player or companion mods (PMDCollab CC BY-NC 4.0, Crystal Clear community, Stadium via user ROM). No Nintendo assets are included.

**Built for Gen1Recomp.** Enjoy the arena.
