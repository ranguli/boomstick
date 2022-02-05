-- pump shotgun, the "Rustington"
local data = {
    name = "Rustington",
    description = "bang",
    category = "pump_shotgun",
    item_name = "rustington",
    capacity = 5,
    textures = {
        icon = "boomstick_rustington_icon.png",
        default = "boomstick_rustington_default.png",
        reload = "boomstick_rustington_reload.png",
    },
    wield_scale = {x = 2, y = 2, z = 1},
    projectile_data = boomstick_data.projectiles["pellet"],
    crafting_recipe = {
        {"", "", ""},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"", "", ""},
    }
}

boomstick.create_new_weapon(data)
