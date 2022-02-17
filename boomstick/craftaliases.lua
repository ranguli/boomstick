-- In order to be compatible with multiple different mods / games,
-- we alias certain items like "default:coal_lump" or "mcl_core:coal_lump" to
-- "boomstick:coal_lump" so that individual crafting recipes aren't concerned with
-- the source of the material, and we aren't touching the item groups of other
-- mod's items.
mods = {
    {
        -- Support for Minetest Game, or anything with the "default" mod.
        mod_name = "default",
        items = {coal_lump = "coal_lump"}
    },
    {
        -- Support for Mineclone 2/5.
        mod_name = "mcl_core",
        items = {coal_lump = "coal_lump", iron_ingot = "iron_ingot"}
    }
}

for _, mod in pairs(mods) do
    if boomstick_api.mod_exists(mod.mod_name) then
        for boomstick_item, mod_item in pairs(mod.items) do
            local boomstick_item_name = "boomstick:" .. boomstick_item
            local mod_item_name = mod.mod_name .. ":" .. mod_item
            minetest.register_alias(boomstick_item_name, mod_item_name)
        end
    end
end

