# boomstick
Boomsticks is a Minetest modpack that adds weapons as well as an API. This mod started out as a fork of one of my favorite Minetest mods, [rangedweapons](https://github.com/daviddoesminetest/rangedweapons), but ended up turning into a complete re-write from scratch. It heavily draws inspiration from rangedweapons and is intended to be a spritual successor. It borrows plenty from that mod, but also does a lot of things differently (especially under the hood in Lua). It isn't meant to necessarily compete with rangedweapons, rather its just my own take on what my ideal weapons mod would look like.

- [Features](#features)
- [User Manual](#user-manual)
  - [Items](#items)
  - [Nodes](#nodes)
- [API Reference](#api-reference)
- [Licensing](#licensing)
- [To-Do](#todo)

## Features
Boomstick has some compelling features:
- **Detailed crafing and weapon mechanics**
  - Recipes for ammo and weapons crafting require a variety of metals, alloys, and intermediary weapon parts.
  - Weapons need to be reloaded, cocked or cycled to fired, and generate recoil.
  - Projectiles are entity-based with velocity and gravity, not hitscans.
- **New blocks**
  - The **Target Node** plays a noise when hit by a projectile.
  - The **Anti-Gun Node** disables the use of weapons within a 10-block radius, just like with [rangedweapons](https://github.com/daviddoesminetest/rangedweapons).
  - The **Bullet Maker** is a specialized crafting bench that turns raw materials like brass and lead into usable components for crafting ammunition.
- **Mod API**
  - Allows modders to create their own weapons or weapons mods. The API is documented thoroughly [here](#api-reference). The default weapons included in Boomstick are implemented using nothing but the API and can also serve as a great reference.
- **Localization support**
  - Built-in localization support. **Translators needed!**
- **No required dependencies**
  - Can run without any dependencies if necessary, **although you will need [Technic](https://github.com/minetest-mods/technic) and [Basic Materials](https://github.com/mt-mods/basic_materials) in order to craft most items**.
- **User Guide**
  - A lot of Minetest mods give players no instruction on how their mod actually works. Boomstick aims to be extremely well-documented, both for players and modders.

## User Manual

### Crafing Items

| Item               | Icon                                                                       | Description                                                                                                        | Recipe                                                          |
|--------------------|----------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| Low-Grade Powder   | <img src="./boomstick/textures/ammo/boomstick_low_grade_powder.png" width=50/>  | Basic powder used by simplistic early-game weapons such as muskets.                                                |<img src="./boomstick/screenshots/recipe_low_grade_powder.png"/> |
| High-Grade Powder  | <img src="./boomstick/textures/ammo/boomstick_high_grade_powder.png" width=50/> | Advanced powder used by all late-game weapons.                                                                     |<img src="./boomstick/screenshots/recipe_high_grade_powder.png"/>|
| Trigger            | <img src="./boomstick/textures/parts/boomstick_trigger.png" width=50/>           | Trigger used in almost all weapons.                                                                                |<img src="./boomstick/screenshots/recipe_trigger.png">           |
| Wrought Iron Long Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used for crafting early-game rifles like muskets.                                                                                |<img src="./boomstick/screenshots/recipe_wrought_iron_long_barrel.png">           |
| Wrought Iron Short Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used for crafting early-game pistols like the musket pistol.                                                                                |<img src="./boomstick/screenshots/recipe_wrought_iron_short_barrel.png">           |
| Cast Iron Long Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used for crafting mid-game rifles and shotguns.                                                                                |<img src="./boomstick/screenshots/recipe_cast_iron_long_barrel.png">           |
| Cast Iron Short Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used for crafting mid-game pistols.                                                                                |<img src="./boomstick/screenshots/recipe_cast_iron_short_barrel.png">           |
| Stainless Steel Long Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used in crafting modern rifles and shotguns.                                                                                |<img src="./boomstick/screenshots/recipe_stainless_steel_long_barrel.png">           |
| Stainless Steel Short Barrel | <img src="./boomstick/textures/parts/boomstick_long_barrel.png" width=50/>     | Used in crafting modern pistols and SMGs.                                                                                |<img src="./boomstick/screenshots/recipe_stainless_steel_short_barrel.png">           |

### Weapons

| Item   | Icon                                                                                  | Description                                                                                                        | Recipe                                                |
|--------|---------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| Rustington | <img src="./boomstick/textures/boomstick_rustington_default.png" width=50/>       | Pump-action shotgun with a 5-round capacity.                                                                       |<img src="./boomstick/screenshots/recipe_rustington.png"/>      |

### Nodes
| Item   | Icon                                                                                  | Description                                                                                                        | Recipe                                                |
|--------|---------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| Target Node | <img src="./boomstick/textures/boomstick_target_node.png" width=50/>             | Makes a "ding" when shot.                                                                                          |<img src="./boomstick/screenshots/recipe_target_node.png"/>      |
| Anti-Gun Node | <img src="./boomstick/textures/boomstick_antigun_node.png" width=50/>          | Prevents the use of any Boomstick weapons within a 10-node radius.                                                 |<img src="./boomstick/screenshots/recipe_antigun.png"/>      |
| Bullet Maker | <img src="./boomstick/textures/bullet_maker/boomstick_bullet_maker_top.png" width=50/>          | Allows the crafting of ammunition.                                                                 |<img src="./boomstick/screenshots/recipe_bullet_maker.png"/>      |

## API Reference

## Licensing

### Code

All code in this project is licensed under the GNU LGPL-2.1.

Any piece of media not listed here is either original work that is licensed under CC0, or is from the excellent [rangedweapons](https://github.com/daviddoesminetest/rangedweapons) mod.

### Assets
| File                                                                                                                           | License                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [boomstick_projectile_pellet](https://opengameart.org/content/cannonball)                                                      | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| [Grenade Texture](https://opengameart.org/content/16x16-grenades)                                                              | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png" width="100px"/> [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) |
| [boomstick_sulfur_lump.png](https://github.com/minetest/minetest_game/blob/master/mods/default/textures/default_coal_lump.png) | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png" width="100px"/> [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) |
| [boomstick_low_grade_powder.png](https://github.com/minetest/minetest_game/blob/master/mods/dye/textures/dye_dark_grey.png) | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png" width="100px"/> [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) |
| [boomstick_empty_2.ogg](https://freesound.org/people/JakLocke/sounds/412294/)                                                  | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by.png" width="100px"/> [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)          |
| [boomstick_shotgun_fire.ogg](https://freesound.org/people/FilmmakersManual/sounds/522484/)                                     | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| [boomstick_shotgun_load.ogg](https://freesound.org/people/FilmmakersManual/sounds/522288/)                                     | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| [boomstick_revolver_load_1.ogg](https://freesound.org/people/Dredile/sounds/177863/)                                           | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| [boomstick_shotgun_fire_2.ogg]()                                                                                               |                                                                                                                                                                     |
| [boomstick_shotgun_fire_3.ogg]()                                                                                               |                                                                                                                                                                     |
| [boomstick_revolver_load_2.ogg]()                                                                                              |                                                                                                                                                                     |
| [boomstick_revolver_load_3.ogg]()                                                                                              |                                                                                                                                                                     |
| [boomstick_revolver_load_4.ogg]()                                                                                              |                                                                                                                                                                     |
| [boomstick_revolver_load_5.ogg]()                                                                                              |                                                                                                                                                                     |
| [boomstick_revolver_empty_1.ogg](https://freesound.org/people/FilmmakersManual/sounds/522415/)                                 | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| [boomstick_revolver_cock_1.oog](https://soundbible.com/1988-Gun-Cocking-Fast.html)                                             | <img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/cc-zero.png" width="100px"/> [CC-0](https://creativecommons.org/publicdomain/zero/1.0/)    |
| boomstick_ding.ogg<sup>[1](https://freesound.org/s/411089/)</sup> <sup>[2](https://freesound.org/s/127149/)</sup> | |
| boomstick_musket_charge.png<sup>[1](https://github.com/minetest/minetest_game/blob/master/mods/default/textures/default_paper.png)</sup> <sup>[2](https://opengameart.org/content/cannonball)</sup> <sup>[3](https://github.com/minetest/minetest_game/blob/master/mods/dye/textures/dye_dark_grey.png)</sup> | |


## To-Do:
- [ ] Add crafting recipes
  - [x] Add a long barrel crafting item + recipe
  - [x] Add a body crafting item + recipe
  - [x] Ammo recipes
  - [ ] Add target block recipe
  - [ ] Antigun block recipe
- [ ] Add knock-back when hit
- [ ] Smoke particles
- [ ] Doors and glass should break when fired at with certain weapons
- [ ] Emit a temporary light source upon firing (muzzle flash)
- [ ] Add settingtypes.txt for server owners
- [ ] Add weapon privilidges for server owners
- [ ] Add more weapons (revolver, rifle, etc)
