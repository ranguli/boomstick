local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(minetest.get_modpath("boomstick_api") .. DIR_DELIM .. "api.lua")

dofile(modpath .. DIR_DELIM .. "projectiles.lua")
dofile(modpath .. DIR_DELIM .. "weapons.lua")

dofile(modpath .. DIR_DELIM .. "craftaliases.lua")

dofile(modpath .. DIR_DELIM .. "crafts" .. DIR_DELIM .. "ammo.lua")
dofile(modpath .. DIR_DELIM .. "crafts" .. DIR_DELIM .. "barrels.lua")
dofile(modpath .. DIR_DELIM .. "crafts" .. DIR_DELIM .. "parts.lua")
dofile(modpath .. DIR_DELIM .. "crafts" .. DIR_DELIM .. "tools.lua")
dofile(modpath .. DIR_DELIM .. "crafts" .. DIR_DELIM .. "weapons.lua")

dofile(modpath .. DIR_DELIM .. "craftitems" .. DIR_DELIM .. "ammo.lua")
dofile(modpath .. DIR_DELIM .. "craftitems" .. DIR_DELIM .. "barrels.lua")
dofile(modpath .. DIR_DELIM .. "craftitems" .. DIR_DELIM .. "parts.lua")
dofile(modpath .. DIR_DELIM .. "craftitems" .. DIR_DELIM .. "tools.lua")

dofile(modpath .. DIR_DELIM .. "nodes" .. DIR_DELIM .. "antigun.lua")
dofile(modpath .. DIR_DELIM .. "nodes" .. DIR_DELIM .. "target.lua")
dofile(modpath .. DIR_DELIM .. "nodes" .. DIR_DELIM .. "bullet_maker.lua")
