boomstick_api = {}
boomstick_api.data = {categories = {}, projectiles = {}, weapons = {}, magazines = {}, ammo = {}, callbacks = {}}

boomstick_api.data.player_height_offset = vector.new(0, 1.5, 0)
boomstick_api.data.particle_lifespan = 5
boomstick_api.data.particle_size = 2

local modpath = minetest.get_modpath("boomstick_api")

dofile(modpath .. "/stack.lua")
dofile(modpath .. "/helpers.lua")
dofile(modpath .. "/projectile.lua")
dofile(modpath .. "/ammo.lua")
dofile(modpath .. "/magazine.lua")
dofile(modpath .. "/weapon.lua")
