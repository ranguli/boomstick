local modpath = minetest.get_modpath(minetest.get_current_modname())

boomstick = {}

boomstick_data = {default_weapon_stats = {}, weapons = {}}

dofile(modpath .. "/weapon.lua")
dofile(modpath .. "/weapons.lua")
dofile(modpath .. "/ammo.lua")
dofile(modpath .. "/projectile.lua")
dofile(modpath .. "/api.lua")

local default_weapons = {pump_shotgun = {"rustington"}}
local default_ammo = {"buckshot"}
local default_projectiles = {"pellet"}
local default_nodes = {"target"}

-- Dynamically load the default weapon files. I don't love this approach.
for weapon_type, weapons in pairs(default_weapons) do
    dofile(modpath .. "/weapons/" .. weapon_type .. ".lua")

    for _, weapon in pairs(weapons) do
        dofile(modpath .. "/weapons/" .. weapon .. ".lua")
    end
end

-- Dynamically load the ammo files.
for _, ammo in pairs(default_ammo) do
    dofile(modpath .. "/ammo/" .. ammo .. ".lua")
end

-- Dynamically load the projectile files.
for _, projectile in pairs(default_projectiles) do
    dofile(modpath .. "/projectiles/" .. projectile .. ".lua")
end

-- Dynamically load the node files.
for _, node in pairs(default_nodes) do
    dofile(modpath .. "/nodes/" .. node .. ".lua")
end

