local default_weapon_stats = boomstick_data.default_weapon_stats

-- General stats for a shotgun. Other shotguns can overwrite or inherit these
-- properties accordingly.

local shotgun_stats = {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
    cycle_weapon_sound = "boomstick_shotgun_rack",
    fire_weapon_sound = "boomstick_shotgun_fire",
    load_weapon_sound = "boomstick_shotgun_load"
}

-- Inherit any default values from the weapon defaults
for k,v in pairs(default_weapon_stats) do
    if shotgun_stats[k] == nil then
        shotgun_stats[k] = v
    end
end

boomstick.create_new_weapon_category("pump_shotgun", shotgun_stats)
