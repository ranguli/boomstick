-- General stats for a weapon. Other categories of weapons can overwrite or inherit
-- these properties accordingly. Indidual weapons should not directly inherit
-- from here.
local data = {
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
    wield_scale = {x = 1.5, y = 1.5, z = 1.5},
    empty_sound = "boomstick_empty"
}

boomstick_data.default_weapon_stats = data
