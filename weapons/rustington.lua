local modpath = minetest.get_modpath(minetest.get_current_modname())
local pellet = dofile(modpath .. "/projectiles/pellet.lua")


local data = {
    name = "Rustington 870",
    category = "pump_shotgun",
    item_name = "rustington",
    capacity = 5,
    textures = {
        icon = "boomstick_rustington_icon.png",
        default = "boomstick_rustington_default.png",
        reload = "boomstick_rustington_reload.png",
    },
    wield_scale = {x = 2, y = 2, z = 2},
    projectile_data = pellet
}

boomstick.create_new_weapon(data)

minetest.register_tool("boomstick:rustington", {
    description = "bang bang",
    wield_scale = data.wield_scale,
    range = 0,
    inventory_image = data.textures.default,
    boomstick_weapon_data = data,
    on_secondary_use = boomstick.weapon_cycle_function,
    on_use = boomstick.weapon_fire_function
})

-- Crafting recipe
minetest.register_craft({
    output = data.item_name,
    recipe = {
        {"", "", ""},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"", "", ""},
    }
})
