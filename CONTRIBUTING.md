# Contributing

## Play Testing Checklist

If you changed any crafting recipes, test for:
- [ ] All the recipes work. Items can still be crafted.

If you changed weapons, the weapons API, or added a new weapon test for:

- Sounds
  - [ ] Loading sounds
  - [ ] Firing sounds
  - [ ] Cycling sounds
  - [ ] Empty sounds
- Projectiles
  - [ ] Projectile physics hasn't been broken
  - [ ] Projectile sprites haven't been broken
- Textures
  - [ ] No missing inventory textures
  - [ ] No missing wield image textures
- Damage / PvP
  - [ ] Shooting a node/player does not throw an error.
  - [ ] Picking up another players weapon (and shooting a node/player) does not throw an error.


## Textures and Sounds Licensing

Any new texures or sounds that are added **must** have their licensing
information entered in `CREDITS.md`.
