local modpath = minetest.get_modpath(minetest.get_current_modname())

boomstick = {}
boomstick.mod_name = "boomstick"

dofile(modpath .. "/player.lua")
dofile(modpath .. "/weapons.lua")
dofile(modpath .. "/weapons/rustington.lua")
dofile(modpath .. "/ammo/shotgun_ammo.lua")
