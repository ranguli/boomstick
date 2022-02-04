local modpath = minetest.get_modpath(minetest.get_current_modname())

boomstick = {}

boomstick_data = {default_weapon_stats = {}, weapons = {}}

dofile(modpath .. "/weapon.lua")
dofile(modpath .. "/weapons.lua")
dofile(modpath .. "/api.lua")

local default_weapons = {pump_shotgun = {"rustington"}}

-- Dynamically load the default weapon files. I don't love this approach.
for weapon_type, weapons in pairs(default_weapons) do
    dofile(modpath .. "/weapons/" .. weapon_type .. ".lua")

    for _, weapon in pairs(weapons) do
        dofile(modpath .. "/weapons/" .. weapon .. ".lua")
    end
end
