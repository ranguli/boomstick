local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(minetest.get_modpath("boomstick_api") .. DIR_DELIM .. "api.lua")

dofile(modpath .. DIR_DELIM .. "projectiles.lua")
dofile(modpath .. DIR_DELIM .. "weapons.lua")

dofile(modpath .. DIR_DELIM .. "craftitems.lua")
dofile(modpath .. DIR_DELIM .. "crafts.lua")
dofile(modpath .. DIR_DELIM .. "nodes.lua")
