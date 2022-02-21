-- generic shotgun weapon category
boomstick_api.create_new_category("shotgun", "weapon", {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
    recoil = 3
})

boomstick_api.create_new_category("semi_rifle", "weapon", {
    projectiles = 1,
    recoil = 2,
    capacity = 10,
    accuracy = 100,
    action = "semi",
    ammo_type = "boomstick:buckshot",
    projectile_data = MediumBulletProjectile
})

-- pump shotgun weapon category
boomstick_api.create_new_category("pump_shotgun", "shotgun", {
    cycle_weapon_sounds = {{name = "boomstick_shotgun_rack"}},
    fire_weapon_sounds = {
        {name = "boomstick_shotgun_fire_1"},
        {name = "boomstick_shotgun_fire_2"},
        {name = "boomstick_shotgun_fire_3"}
    },
    load_weapon_sounds = {{name = "boomstick_shotgun_load_1"}}
})

boomstick_api.create_new_category("old", "weapon", {
    cycle_cooldown = 0.5,
    reload_delay = 5.0,
    action = "manual", -- Currently unused
    wear = 10,
    accuracy = 100,
    projectiles = 1,
    recoil = 5,
    ammo_type = "boomstick:musket_charge",
    cycle_weapon_sounds = {"boomstick_musket_cock"},
    fire_weapon_sounds = {
        {name = "boomstick_shotgun_fire_1"},
        {name = "boomstick_shotgun_fire_2"},
        {name = "boomstick_shotgun_fire_3"}
    },
    load_weapon_sounds = {"boomstick_musket_load_1"}
})

-- pump shotgun, the "Rustington"
boomstick_api.create_new_weapon({
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
})

boomstick_api.create_new_weapon({
    name = "AK-47",
    description = "yeet",
    category = "semi_rifle",
    item_name = "ak47",
    capacity = 10,
    entity_name = "boomstick:ak47",
    textures = {
        icon = "boomstick_ak47.png",
        default = "boomstick_ak47.png",
        unloaded = "boomstick_ak47_unloaded.png"
    },
    wield_scale = {x = 2, y = 2, z = 1},
    --projectile_data = MediumBuletProjectile
})


boomstick_api.create_new_weapon({
    name = "Musket",
    description = "bang",
    category = "old",
    item_name = "musket",
    entity_name = "boomstick:musket",
    capacity = 1,
    textures = {
        icon = "boomstick_musket.png",
        default = "boomstick_musket.png",
        reload = "boomstick_musket.png"
    },
    wield_scale = {x = 2, y = 2, z = 1},
    projectile_data = BallProjectile
})
