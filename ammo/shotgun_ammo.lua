local modpath = minetest.get_modpath(minetest.get_current_modname())
local ammo_stats = dofile(modpath .. "/ammo/ammo.lua")

minetest.register_craftitem("boomstick:buckshot", {
    description = "Buckshot",
    inventory_image = "boomstick_shotgun_ammo.png",
    wield_image = "boomstick_shotgun_ammo.png",
    stack_max = 25,
	recipe = {
		{"", "", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "", ""},
	},
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    on_secondary_use = boomstick.weapon_load_function,
    range=0
})
