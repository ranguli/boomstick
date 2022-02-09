# boomstick
Minetest mod that adds boomsticks and other weapons. This mod draws inspiration from [rangedweapons](https://github.com/daviddoesminetest/rangedweapons) and is intended to be a complete rewrite and spritual successor.

## Features
- **Contributor/mod-friendly** Boomstick provides a well-documented API for creating your own weapons.
- Localization support (translators are needed)
- **New blocks**:
  - The **Target Block** plays a noise when hit by a projectile.

## To-Do:
- [ ] Add projectile drop (based on games current gravity)
- [ ] Add crafting recipes
  - [x] Add a long barrel crafting item + recipe
  - [x] Add a body crafting item + recipe
  - [x] Ammo recipes
  - [ ] Add target block recipe
  - [ ] Add damage block recipe
  - [ ] Antigun block recipe
- [ ] Document the API
- [ ] Add knock-back when hit
- [ ] Add an anti-gun block
- [ ] Add durability effects
- [ ] Add a damage block that sends a chat message with the amount of damage dealt
- [ ] Loaded ammunition does not persist after restart
- [ ] Smoke particles
- [ ] Doors and glass should break when fired at with certain weapons
- [ ] Emit a temporary light source upon firing (muzzle flash)
- [ ] Add settingtypes.txt for server owners
- [ ] Add weapon privilidges for server owners
- [ ] Add more weapons (revolver, rifle, etc)
