boomstick = {}
boomstick.data = {categories = {}, projectiles = {}, weapons = {}}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath .. "/api/helpers.lua")
dofile(modpath .. "/api/projectile.lua")
dofile(modpath .. "/api/weapon.lua")
dofile(modpath .. "/api/weapon_functions.lua")

