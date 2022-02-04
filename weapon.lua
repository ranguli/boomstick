-- General stats for a weapon. Other categories of weapons can overwrite or inherit
-- these properties accordingly. Indidual weapons should not directly inherit
-- from here.
local data = {
    rounds_loaded = 0,
    round_count = 0,
    accuracy = 85,
    fire_rate = 0.9,
    cycle_cooldown = 0.25,
    fire_cooldown = 2.25,
    reload_delay = 0.5,
    durability = 1000,
    action = "manual",
    ready = true,
    wield_scale = {x = 1.5, y = 1.5, z = 1.5},
    empty_sound = "boomstick_empty"
}

boomstick_data.default_weapon_stats = data
