local modpath = minetest.get_modpath(minetest.get_current_modname())

--- i am a module here called boomstick!

dofile(modpath .. "/api.lua")

dofile(modpath .. "/projectiles.lua")

dofile(modpath .. "/weapons/weapon_categories.lua")
dofile(modpath .. "/weapons/weapon_definitions.lua")

dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/crafts.lua")
dofile(modpath .. "/items/nodes.lua")
