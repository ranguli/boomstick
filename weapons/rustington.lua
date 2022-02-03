local modpath = minetest.get_modpath(minetest.get_current_modname())
local weapon_stats = dofile(modpath .. "/weapons/shotgun.lua")

-- Attributes for the weapon
local data = {
    name = "Rustington 870",
    item_name = "rustington",
    capacity = 5,
    texture = {
        icon = "boomstick_rustington_icon.png",
        default = "boomstick_rustington_default.png",
        reload = "boomstick_rustington_reload.png",
    },
    wield_scale = {x = 2, y = 2, z = 2}
}

-- Populate any unset values with shotgun defaults
for k,v in pairs(weapon_stats) do
    if data[k] == nil then
        data[k] = v
    end
end

for k,v in pairs(data) do
    print(k)
    print(v)
end


minetest.register_tool(boomstick.mod_name .. ":" .. data.item_name, {
    --description = boomstick.generate_weapon_description(data),
    description = "bang bang",
	wield_scale = data.wield_scale,
	range = 0,
	inventory_image = data.texture.default,
    boomstick_weapon_data = data,
    on_secondary_use = weapon_cycle,
    on_use = weapon_fire
})

-- Crafting recipe
minetest.register_craft({
	output = data.item_name,
	recipe = {
		{"", "", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "", ""},
	}
})

