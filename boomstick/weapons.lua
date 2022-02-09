-- generic shotgun weapon category
boomstick_api.create_new_category("shotgun", "weapon",
    {projectiles = 9, ammo_type = "boomstick:buckshot"})

-- pump shotgun weapon category
boomstick_api.create_new_category("pump_shotgun", "shotgun", {
    cycle_weapon_sounds = {"boomstick_shotgun_rack"},
    fire_weapon_sounds = {
        "boomstick_shotgun_fire_1",
        "boomstick_shotgun_fire_2",
        "boomstick_shotgun_fire_3"
    },
    load_weapon_sounds = {"boomstick_shotgun_load_1", "boomstick_shotgun_load_2"}
})

-- pump shotgun, the "Rustington"
local data = {
    name = "Rustington",
    description = "bang",
    category = "pump_shotgun",
    item_name = "rustington",
    entity_name = "boomstick:rustington",
    capacity = 5,
    textures = {
        icon = "boomstick_rustington_icon.png",
        default = "boomstick_rustington_default.png",
        reload = "boomstick_rustington_reload.png"
    },
    wield_scale = {x = 2, y = 2, z = 1},
    projectile_data = PelletProjectile
}

boomstick_api.create_new_weapon(data)
