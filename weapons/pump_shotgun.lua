local modpath = minetest.get_modpath(minetest.get_current_modname())

-- General stats for a pump-action shotgun. Other shotguns can overwrite or inherit these
-- properties accordingly.

local shotgun_stats = {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
    cycle_weapon_sound = "boomstick_shotgun_rack",
    fire_weapon_sound = "boomstick_shotgun_fire",
    load_weapon_sound = "boomstick_shotgun_load"
}

boomstick.create_new_weapon_category("pump_shotgun", shotgun_stats)
