local modpath = minetest.get_modpath(minetest.get_current_modname())
local weapon_stats = dofile(modpath .. "/weapons/" .. "weapon.lua")

-- General stats for a shotgun. Other shotguns can overwrite or inherit these
-- properties accordingly.

local shotgun_stats = {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
    cycle_weapon_sound = "boomstick_shotgun_rack",
    fire_weapon_sound = "boomstick_shotgun_fire",
}

-- Inherit any default values from the weapon defaults
for k,v in pairs(weapon_stats) do
    if shotgun_stats[k] == nil then
        shotgun_stats[k] = v
    end
end


return shotgun_stats
