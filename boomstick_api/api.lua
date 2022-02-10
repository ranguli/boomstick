boomstick_api = {}
boomstick_api.data = {categories = {}, projectiles = {}, weapons = {}, callbacks = {}}

local modpath = minetest.get_modpath("boomstick_api")

dofile(modpath .. "/helpers.lua")
dofile(modpath .. "/projectile.lua")
dofile(modpath .. "/weapon.lua")
