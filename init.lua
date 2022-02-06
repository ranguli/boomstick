local modpath = minetest.get_modpath(minetest.get_current_modname())

boomstick = {}
boomstick_data = {categories = {}, projectiles = {}, weapons = {}}

dofile(modpath .. "/api.lua")

dofile(modpath .. "/projectiles/projectile_categories.lua")
dofile(modpath .. "/projectiles/projectile_definitions.lua")

dofile(modpath .. "/weapons/weapon_functions.lua")
dofile(modpath .. "/weapons/weapon_categories.lua")
dofile(modpath .. "/weapons/weapon_definitions.lua")

dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/crafts.lua")
dofile(modpath .. "/items/nodes.lua")
