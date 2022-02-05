-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

-- weapon stats + categories that weapon implementations can use

local default_stats = {
    rounds_loaded = 0,
    round_count = 0,
    accuracy = 85, -- Currently unused
    fire_rate = 0.9, -- Currently unused
    cycle_cooldown = 0.35,
    fire_cooldown = 0.35,
    reload_delay = 0.55,
    durability = 1000, -- Currently used
    action = "manual", -- Currently unused
    ready = true,
    ammo_ready = true,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
    empty_sound = "boomstick_empty"
}

boomstick.create_new_category("weapon", nil, default_stats)

-- generic shotgun weapon category
boomstick.create_new_category("shotgun", "weapon", {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
})


-- pump shotgun weapon category
boomstick.create_new_category("pump_shotgun", "shotgun", {
    cycle_weapon_sound = "boomstick_shotgun_rack",
    fire_weapon_sound = "boomstick_shotgun_fire",
    load_weapon_sound = "boomstick_shotgun_load",
})
